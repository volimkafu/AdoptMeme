AdoptMeme.Views.captionDetailView = Backbone.View.extend({
	template: JST['captions/detail'],
	className: 'cat-tile',

	render: function () {
	    var that = this;
	    var renderedContent = this.template({ caption: that.model.attributes });
	    this.$el.html(renderedContent);
	    return this
	}
})