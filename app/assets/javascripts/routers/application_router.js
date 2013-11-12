AdoptMeme.Routers.applicationRouter = Backbone.Router.extend({
  routes: {
    "":"petsIndex",
    ":imageid/new": 'captionCreate',
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

  captionCreate: function (image_id) {
    var that = this;
    AdoptMeme.petImages.fetch({
      success: function () {
        var newCaptionView = new AdoptMeme.Views.newCaptionView({
          model: AdoptMeme.petImages.get(image_id)
        });
        that._swapView(newCaptionView)
        newCaptionView.animateEditor()
      }
    })
  },

  captionsIndex: function () {
    var that = this;
    AdoptMeme.petImages.fetch({
      success: function () {
        var petCaptionsView = new AdoptMeme.Views.petCaptionsView({
          collection: AdoptMeme.petImages
        });
        that._swapView(petCaptionsView)
      }
    })
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
})