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
		this.$el.html(renderedContent);
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
				console.log("Error: There was a problem uploading the image data.")
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

    var center_x = canvas.width / 2;
    var bottom_y = canvas.height - 50;

    context.textAlign = "center";
    context.lineWidth = 3;
    context.fillStyle = "white";
    context.strokeStyle = "black";

    this.drawTopText(topText, center_x, 65);

    context.lineWidth = 2.5;
    this.drawBottomText(bottomText, center_x);
  },

  drawText: function (text, xpos, ypos) {
  	var context = this.$context;
  	var canvas = this.$canvas;
    var startText = text.slice(0,30);
    context.fontsize = 90;
    context.font = "bold "+context.fontsize+"px Impact, sans-serif";
    while (context.measureText(startText).width > (canvas.width-20)) {
      ypos = ypos - 2;
      console.log(console.fontsize);
      context.fontsize = context.fontsize - 4;
      context.lineWidth = context.lineWidth - 0.1;
      context.font = "bold "+context.fontsize+"px Impact, sans-serif";
    }

    context.fillText(startText, xpos, ypos);
    context.strokeText(startText, xpos, ypos);
  },

  drawTopText: function (text, xpos, ypos) {
    this.drawText(text.slice(0,30), xpos, ypos);
    if (text.slice(30) !== "") {
      this.drawTopText(text.slice(30), xpos, ypos+40);
    }
  },

  drawBottomText: function (text, xpos) {
  	var canvas = this.$canvas;
    var lines = Math.ceil(text.length/30);
    var ypos = canvas.height - lines*30;
    for (var i=0; i < lines; i++) {
      this.drawText(text.slice(i*30, (i+1)*30), xpos, ypos);
      ypos += 40;
    }
  }

});