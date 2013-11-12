AdoptMeme.Collections.pets = Backbone.Collection.extend({
	model: AdoptMeme.Models.pet,

	info: "collection pets",

	url: '/pets'
})