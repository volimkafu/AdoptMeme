AdoptMeme.Views.captionShowView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST['captions/show'],

  render: function () {
    var renderedContent = this.template({ caption: this.model })
    this.$el.html(renderedContent)
    return this
  }
})