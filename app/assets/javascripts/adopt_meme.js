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
    // Backbone.history.start();
    Backbone.history.start({pushState: true})
  }
};

$(document).ready(function(){
  AdoptMeme.initialize();
});

// Helpfully provided by http://dev.tenfarms.com/posts/proper-link-handling
$(document).on("click", "a[href^='/']", function(event) {
  if (!event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey) {
    event.preventDefault();
    var url = $(event.currentTarget).attr("href").replace(/^\//, "");
    AdoptMeme.Routers.router.navigate(url, { trigger: true });
  }
});