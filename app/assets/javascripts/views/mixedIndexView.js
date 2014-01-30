AdoptMeme.Views.mixedIndexView = Backbone.View.extend({
  initialize: function (options) {
    this.petImages = options.petImages;
    this.captions = options.captions;
    this.listenTo(this.petImages, "change sync", this.render);
    this.listenTo(this.captions, "change sync", this.render);
  },

  $el: $(".content-container"),

  template: JST['pets/index'],

  events: {
    "click #get-started":"scrollToStart"
  },

  scrollToStart: function (event) {
    console.log("trigger");
    $('html,body').animate({
        scrollTop: document.documentElement.scrollTop() + 100
    })
  },

  render: function () {
    var $tileContainer = $("<div class='tile-container clearfix'></div>")
    var $col1 = $("<div class='column'></div>")
    var $col2 = $("<div class='column'></div>")
    var $col3 = $("<div class='column'></div>")
    var $col4 = $("<div class='column'></div>")

    var that = this;
    var newDivs = [];

    this.petImages.each( function (pet, idx) {
      var petDetail = new AdoptMeme.Views.petDetailView({ model: pet })
      petDetail.render();
      petDetail.$el.addClass("greyscale");
      newDivs.push(petDetail.$el);
    })

    this.captions.each( function (pet, idx) {
      var petDetail = new AdoptMeme.Views.captionDetailView({ model: pet })
      petDetail.render();
      newDivs.push(petDetail.$el);
    })

    newDivs = _.shuffle(newDivs);

    newDivs.forEach( function (div, idx) {
      if (idx % 4 === 0) {
        $col1.append(div);
      } else if (idx % 4 === 1) {
        $col2.append(div);
      } else if (idx % 4 === 2) {
        $col3.append(div);
      } else if (idx % 4 === 3) {
        $col4.append(div);
      }
    })

    $tileContainer.append($col1);
    $tileContainer.append($col2);
    $tileContainer.append($col3);
    $tileContainer.append($col4);
    that.$el.html(JST['layouts/hero'])
    that.$el.append($tileContainer);
    return this
  }
})