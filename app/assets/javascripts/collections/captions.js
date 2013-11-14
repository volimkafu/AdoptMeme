AdoptMeme.Collections.captions = Backbone.Collection.extend({
	info: 'collection captions',
	url: '/api/captions',
  model: AdoptMeme.Models.caption
})