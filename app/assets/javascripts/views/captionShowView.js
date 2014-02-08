AdoptMeme.Views.captionShowView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST["captions/show"],

  initialize: function (options) {
    this.captionid = options.captionid;
    this.listenTo(this.model, "change sync", this.render);
  },

  render: function () {
    var innerContainer = $("<div class='inner-container'>");
    var caption = this.model;

    if (caption) {
      var renderedContent = $(this.template({ caption: caption.attributes }));
      var pet = AdoptMeme.pets.get({id: caption.attributes.pet_id });
      // var pet = new AdoptMeme.Models.pet({id: caption.attributes.pet_id});
      pet.set({"image_id": caption.attributes.image_id});
      var petAdoptionInfoView = new AdoptMeme.Views.petAdoptionInfo({model: pet});
      innerContainer.append(renderedContent);
      innerContainer.append(petAdoptionInfoView.render().$el);
    }

    this.$el.html(innerContainer);
		return this;
  }
});