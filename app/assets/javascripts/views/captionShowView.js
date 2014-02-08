AdoptMeme.Views.captionShowView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST["captions/show"],

  initialize: function (options) {
    this.captionid = options.captionid;
    this.listenTo(this.model, "change sync", this.render);
  },

  render: function () {
    var renderedContent, pet, petAdoptionInfoView;
    var innerContainer = $("<div class='inner-container'>");
    var caption = this.model;

    if (typeof caption === "object") {
      renderedContent = $(this.template({ caption: caption.attributes }));
      pet = AdoptMeme.pets.get({id: caption.attributes.pet_id });
      petAdoptionInfoView = new AdoptMeme.Views.petAdoptionInfoView({model: pet});
      pet.set({"image_id": caption.attributes.image_id});
      innerContainer.append(renderedContent);
      innerContainer.append(petAdoptionInfoView.render().$el);
    } else {
      throw "captionShowView cannot render without a defined caption";
    }

    this.$el.html(innerContainer);
		return this;
  }
});