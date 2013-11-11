AdoptMeme.Views.catTileView = Backbone.View.extend({
  className: "cat-tile",

  template: JST["pets/cat-tile"],

  render: function () {
    var that = this;
    var renderedContent = this.template({ pet: that.model });
    this.$el.html(renderedContent);
    return this
  }

})