AdoptMeme.Views.petsIndexView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST['pets/index'],

  render: function () {
    var that = this;
    this.collection.each( function (pet) {
      var petDetail = new AdoptMeme.Views.catTileView({ model: pet })
      petDetail.render()
      that.$el.append(petDetail.$el)
    })
    return this
  }
})