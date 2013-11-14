AdoptMeme.Views.captionShowView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST['captions/show'],

  initialize: function () {
    this.listenTo(this.collection, "change sync", this.render);
  },

  initialize: function (options) {
  	this.captionid = options.captionid;
  	this.listenTo(this.collection, "change sync", this.render);
    this.collection.fetch()
  },

  render: function () {
  	var caption = this.collection.get(this.captionid)
    
    if (caption) {
      var renderedContent = this.template({ caption: caption.attributes });
      this.$el.html(renderedContent);
    }

		return this
  }
})