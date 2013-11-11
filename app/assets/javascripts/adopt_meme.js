window.AdoptMeme = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.petImages = new AdoptMeme.Collections.petImages();
    AdoptMeme.Routers.router = new AdoptMeme.Routers.applicationRouter({
      "$rootEl": $('.container')
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  AdoptMeme.initialize();
});
