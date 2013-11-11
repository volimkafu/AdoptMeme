AdoptMeme.Routers.applicationRouter = Backbone.Router.extend({
  routes: {
    "":"petsIndex",
    "captions":"captionsIndex"
  },

  $el: ".container",

  petsIndex: function () {
    var that = this;
    AdoptMeme.petImages.fetch({
      success: function () {
        var petsIndexView = new AdoptMeme.Views.petsIndex({
          collection: AdoptMeme.petImages
        });
        that.$el.html(petsIndexView.render().$el);
      },
      error: function () {
        alert('You suck.')
      }
    })
  },

  captionsIndex: function () {}
})