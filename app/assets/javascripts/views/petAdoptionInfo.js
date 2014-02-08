AdoptMeme.Views.petAdoptionInfo = Backbone.View.extend({
  className: "pet-description",

  template: JST["pets/adoption"],

  render: function () {
    var that = this;
    var renderedContent = this.template({ pet: that.model.attributes });
    this.$el.html(renderedContent);
    return this;
  }

});