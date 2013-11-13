AdoptMeme.Views.petDetailView = Backbone.View.extend({
  className: "cat-tile",

  template: JST["pets/cat-tile"],

  render: function () {
    var that = this;
    var renderedContent = this.template({ image: that.model.attributes });
    this.$el.html(renderedContent);
    return this
  }

})