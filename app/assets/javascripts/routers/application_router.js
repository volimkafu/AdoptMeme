AdoptMeme.Routers.applicationRouter = Backbone.Router.extend({
  routes: {
    "":"mixedIndex",
    "pets":"petsIndex",
    ":imageid/new": "captionCreate",
    "captions":"captionsIndex",
    ":captionid": "captionShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl  ;
  },

  petsIndex: function () {
    var that = this;
    AdoptMeme.petImages.fetch();
    var petsIndexView = new AdoptMeme.Views.petsIndexView({
      collection: AdoptMeme.petImages
    });
    that._swapView(petsIndexView);
  },

  captionCreate: function (image_id) {
    var that = this;
    AdoptMeme.petImages.fetch({
      success: function () {
        var newCaptionView = new AdoptMeme.Views.newCaptionView({
          model: AdoptMeme.petImages.get(image_id)
        });
        that._swapView(newCaptionView);
        newCaptionView.configureEditor();
      }
    });
  },

  captionsIndex: function () {
    var that = this;
    AdoptMeme.captions.fetch();
    var captionsIndex = new AdoptMeme.Views.petsIndexView({
      collection: AdoptMeme.captions
    });
    that._swapView(captionsIndex);
  },

  mixedIndex: function () {
    var that = this;
    AdoptMeme.captions.fetch();
    AdoptMeme.petImages.fetch();
    var mixedIndex = new AdoptMeme.Views.mixedIndexView({
      captions: AdoptMeme.captions,
      petImages: AdoptMeme.petImages
    });
    that._swapView(mixedIndex);
  },

  captionShow: function (captionid) {
    if (!isNaN(parseInt(captionid))) {
      var that = this;
      var caption = new AdoptMeme.Models.caption({id: captionid});
      caption.fetch({
        success: function () {
          var captionShowView = new AdoptMeme.Views.captionShowView({
            model: caption,
            captionid: captionid
          });
          that._swapView(captionShowView);
        },
        error: function () {
          that.redirectHome();
        }
      });

      AdoptMeme.captions.add(caption);
    } else {
      this.redirectHome();
    }
  },

  redirectHome: function () {
    console.log("Redirecting to home.");
    AdoptMeme.Routers.router.navigate("", { trigger: true });
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }, 

  _overlayView: function (view) {
    this._overlay = $("<div>").addClass("overlay");
    overlay.html(view.$el);
    this._currentView = this._currentView.$el.append(overlay);
  },

  _removeOverlay: function () {
    
  }
});