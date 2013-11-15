AdoptMeme.Models.caption = Backbone.Model.extend({
	info: 'model caption',

	urlRoot: '/api/captions',

  parse: function (data, options) {
    var pet = new AdoptMeme.Models.pet(data.image_pet);
    AdoptMeme.pets.add(pet);

    data.pet_id = pet.id;
    delete data.image_pet;
    return data;
  }

})