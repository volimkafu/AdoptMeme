window.AdoptMeme = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.pets = new AdoptMeme.Collections.pets();
    this.petImages = new AdoptMeme.Collections.petImages();
    this.captions = new AdoptMeme.Collections.captions();
    AdoptMeme.Routers.router = new AdoptMeme.Routers.applicationRouter({
      "$rootEl": $('.content-container')
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  AdoptMeme.initialize();
});
