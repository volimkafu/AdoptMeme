AdoptMeme.Collections.petImages = Backbone.Collection.extend({
  model: AdoptMeme.Models.petImage,

  url: '/api/images',

  info: 'collection petImages',

})