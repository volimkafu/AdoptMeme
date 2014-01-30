AdoptMeme.Views.captionDetailView = Backbone.View.extend({
	template: JST['captions/detail'],
	className: 'cat-tile',

	render: function () {
	    var that = this;
	    var renderedContent = this.template({ caption: that.model.attributes });
	    this.$el.html(renderedContent);
      this.$el.css("margin-bottom", window.innerWidth*0.02);
	    return this
	}
})