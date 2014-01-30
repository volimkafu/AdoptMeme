AdoptMeme.Views.mixedIndexView = Backbone.View.extend({
  initialize: function (options) {
    this.petImages = options.petImages;
    this.captions = options.captions;
    this.listenTo(this.petImages, "change sync", this.render);
    this.listenTo(this.captions, "change sync", this.render);
  },

  $el: $(".content-container"),

  template: JST['pets/index'],

  render: function () {
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

    that.$el.html(_.shuffle(newDivs));
    return this
  }
})