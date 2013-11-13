AdoptMeme.Views.captionsIndexView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST['pets/index'],

  render: function () {
    var that = this
    var petColumn1 = $("<div class='cat-tile-column'>")
    var petColumn2 = $("<div class='cat-tile-column'>")
    var petColumn3 = $("<div class='cat-tile-column'>")

    this.collection.each( function (caption, idx) {
      var captionDetail = new AdoptMeme.Views.captionDetailView({ model: caption })
      captionDetail.render()

      switch (idx % 3) {
        case 0:
          petColumn1.append(captionDetail.$el)
          break;
        case 1:
          petColumn2.append(captionDetail.$el)
          break;
        case 2:
          petColumn3.append(captionDetail.$el)
          break;
      }
    })
    $tileContainer = $('<div class="cat-tile-container">')
    $tileContainer.append(petColumn1)
    $tileContainer.append(petColumn2)
    $tileContainer.append(petColumn3)
    that.$el.html($tileContainer)
    return this
  }
})