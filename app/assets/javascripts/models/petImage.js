AdoptMeme.Models.petImage = Backbone.Model.extend({
	info: "model petImage",

	parse: function (data, options) {
		var pet = new AdoptMeme.Models.pet(data.pet);
		AdoptMeme.pets.add(pet);
		delete data.pet;
		return data;
	}
})