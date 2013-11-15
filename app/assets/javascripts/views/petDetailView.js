AdoptMeme.Views.petDetailView = Backbone.View.extend({
  className: 'cat-tile',

  template: JST["pets/cat-tile"],

  events: {
    "mouseenter": "toggleHoverCard",
    "mouseleave": "toggleHoverCard"
  },

  toggleHoverCard: function (event) {
    this.$el.find('.hovercard').toggle()
    this.$el.find('.hovertext').slideToggle('fast')
  },

  render: function () {
    var that = this;
    var renderedContent = this.template({ image: that.model.attributes });
    this.$el.html(renderedContent);
    return this
  }

})