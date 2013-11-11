AdoptMeme.Views.petsIndexView = Backbone.View.extend({
  $el: "#content-container",

  template: JST['pets/index'],

  render: function () {
    var that = this;
    this.collection.each( function (pet) {
      var petDetail = new catTileView({ model: pet })
      petDetail.render()
      that.$el.append(petDetail.$el)
    })
    this.$el.html(renderedContent.$el)
    return this
  }
})