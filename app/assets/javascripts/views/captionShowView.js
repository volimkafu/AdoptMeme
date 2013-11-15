AdoptMeme.Views.captionShowView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST['captions/show'],

  initialize: function (options) {
  	this.captionid = options.captionid;
  	this.listenTo(this.collection, "change sync", this.render);
  },

  render: function () {
    var innerContainer = $("<div class='inner-container'>")
  	var caption = this.collection.get(this.captionid)

    if (caption) {
      var renderedContent = $(this.template({ caption: caption.attributes }));
      var pet = AdoptMeme.pets.get({id: caption.attributes.pet_id })
      pet.set({"image_id": caption.attributes.image_id});
      var petAdoptionInfoView = new AdoptMeme.Views.petAdoptionInfo({model: pet})
      innerContainer.append(renderedContent);
      innerContainer.append(petAdoptionInfoView.render().$el)
    }
    console.log(innerContainer)
    this.$el.html(innerContainer)
		return this
  }
})