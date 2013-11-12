AdoptMeme.Routers.applicationRouter = Backbone.Router.extend({
  routes: {
    "":"petsIndex",
    "captions":"captionsIndex"
  },

  initialize: function (options) {
    this.$rootEl = options["$rootEl"]
  },

  petsIndex: function () {
    var that = this;
    AdoptMeme.petImages.fetch({
      success: function () {
        var petsIndexView = new AdoptMeme.Views.petsIndexView({
          collection: AdoptMeme.petImages
        });
        that._swapView(petsIndexView)

      }
    })
  },

  captionsIndex: function () {},

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
})