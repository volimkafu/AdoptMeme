AdoptMeme.Views.petsIndexView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST['pets/index'],

  initialize: function () {
    this.listenTo(this.collection, "change sync", this.render);
  },

  render: function () {
    var that = this;

    this.collection.each( function (pet, idx) {
      var petDetail = new AdoptMeme.Views.petDetailView({ model: pet })
      petDetail.render()
      that.$el.append(petDetail.$el)
    })

    return this
  }
})