AdoptMeme.Views.newCaptionView = Backbone.View.extend({
	$el: $(".content-container"),

	template: JST['captions/new'],

	render: function () {
		var renderedContent = this.template({ 
			pet: AdoptMeme.pets.get(this.model.attributes.pet_id),
			image: this.model.attributes
		})
		this.$el.html(renderedContent)
		return this
	}
	
})