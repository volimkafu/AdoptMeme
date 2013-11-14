AdoptMeme.Views.captionShowView = Backbone.View.extend({
  $el: $(".content-container"),

  template: JST['captions/show'],

  initialize: function (options) {
  	this.captionid = options.captionid;
  	this.listenTo(this.collection, "change sync", this.render);
  },

  render: function () {
  	var caption = this.collection.get(this.captionid)
  	if (caption) {
      debugger
	    var renderedContent = this.template({ caption: caption.attributes })
	    this.$el.html(renderedContent)
	    return this
  	} else {
  		this.collection.fetch()
  		return this
  	}
  }
})