AdoptMeme.Collections.petImages = Backbone.Collection.extend({
  model: AdoptMeme.Models.petImage,

  url: '/images',

  info: 'collection petImages',

})