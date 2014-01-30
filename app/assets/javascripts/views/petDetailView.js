AdoptMeme.Views.petDetailView = Backbone.View.extend({
  className: 'cat-tile',

  template: JST["pets/cat-tile"],

  events: {
    "mouseenter": "toggleHoverCard",
    "mouseleave": "toggleHoverCard"
  },

  toggleHoverCard: function (event) {
    this.$el.find('.hovercard').toggle()
    // this.$el.find('.hovertext').slideToggle({duration: 50})
    this.$el.toggleClass('greyscale')
  },

  render: function () {
    var that = this;
    var bgString = 'url("' + this.model.attributes.amazon_aws_url + '") no-repeat center center';
    var renderedContent = this.template({ image: that.model.attributes });
    this.$el.html(renderedContent);

    this.$el.css("background", bgString);
    this.$el.addClass("cf")
    return this
  }

})