AdoptMeme.Views.catTileView = Backbone.View.extend({
  className: "cat-tile",

  template: JST["pets/cat-tile"],

  render: function () {
    var that = this;
    debugger
    var renderedContent = this.template({ image: that.model });
    this.$el.html(renderedContent);
    return this
  }

})