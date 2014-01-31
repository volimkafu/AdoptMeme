AdoptMeme.Views.newCaptionView = Backbone.View.extend({
	$el: $(".content-container"),

	template: JST["captions/new"],

	events: {
		"click .submit": "postCaptionCreate",
		"keyup" : "refreshText",
	},

	render: function () {
		var renderedContent = this.template({
			pet: AdoptMeme.pets.get(this.model.attributes.pet_id),
			image: this.model.attributes
		});
    this.$el.html(JST["layouts/topbar"]);
		this.$el.append(renderedContent);
		return this;
	},

	postCaptionCreate: function (event) {
		var that = this;
		event.preventDefault();
		this.$el.find(".loadmsg").slideToggle("slow");
		this.$el.find(".submit").slideToggle("fast");
		var formData = $("form").serializeJSON();
		var caption = new AdoptMeme.Models.caption(formData.caption);
		caption.save({}, {
			success: function () {
				AdoptMeme.captions.add(caption);
				that.watermarkImage(caption);
				that.uploadImage(caption);
			},
			error: function () {
				console.log("Error: There was a problem uploading the image data.");
				AdoptMeme.Routers.router.navigate("/", {trigger: true});
			}});
	},

	watermarkImage: function (caption) {
		var watermark = "AdoptMe.me/" + caption.id;
		var context = this.$context;
		var xpos = this.$canvas.width;
		var ypos = this.$canvas.height - 5;

		// Add colored background
		context.fillStyle = "black";
		context.fillRect(xpos-170, ypos-15, xpos, ypos + 10);

		// Draw watermark text
		context.fillStyle = "white";
		context.font = "bold 20px Arial, sans serif";
		context.textAlign = "right";

		this.$context.fillText(watermark, xpos, ypos);
	},

	uploadImage: function (caption) {
		caption.set( { "imgData" : this.$canvas.toDataURL() });

		caption.save({},
			{
				success: function () {
						var route = "/"+caption.id.toString();
						AdoptMeme.Routers.router.navigate(route, {trigger: true});
				},
				error: function () {
						console.log("Error: There was a problem uploading the photo");
						AdoptMeme.Routers.router.navigate("/", {trigger: true});
				}
			}
		);
	},

	configureEditor: function () {
	  var canvas = this.$canvas = $("#catCanvas")[0];
	  var context = this.$context = canvas.getContext("2d");
    this.maxLineLength = 25;

	  var background = this.background = new Image();
	  background.src = "/api/proxy_images/" + this.model.attributes.id;

	  this.$topText = $("#toptext");

	  // Make sure the image is loaded first otherwise nothing will draw.
	  background.onload = function(){
	      canvas.width = this.width;
	      canvas.height = this.height;
	      $(".canvas-container").css("width", this.width);
	      $(".editor-container").css("width", this.width);
	      context.drawImage(background,0,0);
	    };
	  },

  refreshText: function () {
    var context = this.$context;
    var canvas = this.$canvas;
    var topText = this.$topText.val().toUpperCase();
    var bottomText = $("#bottomtext").val().toUpperCase();

    context.drawImage(this.background,0,0);
    context.lineJoin = "bevel";

    this.center = canvas.width / 2;

    context.textAlign = "center";
    context.lineWidth = 5;
    context.fillStyle = "white";
    context.strokeStyle = "black";

    this.drawTopText(topText);

    context.lineWidth = 2.5;
    this.drawBottomText(bottomText);
  },

  drawTopText: function (toptext) {
    var lines = this.buildLines(toptext);
    if (lines.length > 1) {
      this.drawMultiLineTopText(lines);
    } else {
      this.configureTextSize(toptext);
      this.drawSingleLineText(toptext, 0.9*this.$context.fontsize);
    }
  },

  drawBottomText: function (bottomText) {
    var lines = this.buildLines(bottomText);
    var canvas = this.$canvas;
    if (lines.length > 1) {
      this.drawMultiLineBottomText(lines);
    } else {
      this.configureTextSize(bottomText);
      this.drawSingleLineText(bottomText, canvas.height - 25);
    }
  },

  drawMultiLineBottomText: function (lines) {
    var that = this;
    var line = this.longestLine(lines);
    this.configureTextSize(line);
    var startHeight = this.$canvas.height-0.9*this.$context.fontsize*lines.length;
    var context = this.$context;
    
    lines.forEach( function (line, index) {
      var tempsize = startHeight+index*context.fontsize*0.90;
      context.fillText(line, that.center, tempsize);
      context.strokeText(line, that.center, tempsize);
    });

  },

  drawMultiLineTopText: function (lines) {
    var that = this;
    var line = this.longestLine(lines);
    this.configureTextSize(line);
    var startHeight = 0.9*this.$context.fontsize;
    var context = this.$context;
    
    lines.forEach( function (line, index) {
      var tempsize = startHeight+index*context.fontsize*0.90;
      context.fillText(line, that.center, tempsize);
      context.strokeText(line, that.center, tempsize);
    });
  },

  configureTextSize: function (text) {
    var context = this.$context;
    var canvas = this.$canvas;
    context.lineWidth = 4;
    context.fontsize = 80;
    context.font = "bold "+context.fontsize+"px Impact, sans-serif";

    while (context.measureText(text).width > (canvas.width-30)) {
      context.fontsize = context.fontsize - 2;
      context.lineWidth = Math.max.apply(null, [context.lineWidth - 0.2, 2]);
      context.font = "bold "+context.fontsize+"px Impact, sans-serif";
    }
  },

  drawSingleLineText: function (text, ypos) {
    var context = this.$context;

    context.fillText(text, this.center, ypos);
    context.strokeText(text, this.center, ypos);
  },

  wordSplit: function (str) {
    var that = this;
    words = str.split(" ");
    var newWords = [];

    words.forEach( function (word) {
      if (word.length >= that.maxLineLength) {
        var chunker = new RegExp(".{1,"+that.maxLineLength+"}", "g");
        var chunks = word.match(chunker);
        newWords = newWords.concat(chunks);
      } else {
        newWords.push(word);
      }
    });

    return newWords;
  },

  buildLines: function (str) {
    var words = this.wordSplit(str);
    var maxLineLength = this.maxLineLength;
    var lines = [];
    var currentLine = [];

    while (words.length !== 0) {
      var newstr = currentLine.concat(words[0]).join(" ");
      
      if (newstr.length > maxLineLength) {
        lines.push(currentLine.join(" "));
        currentLine = [];
      } else {
        currentLine.push( words.shift() );
      }
    }
    lines.push(currentLine.join(" "));

    return lines;
  },

  longestLine: function (lines) {
     var longest = lines[0];
     for (var i = 0; i < lines.length; i++) {
        if (this.$context.measureText(longest).width < this.$context.measureText(lines[i]).width) {
          longest = lines[i];
        }
     }
     console.log(longest);
     return longest;
  },


});