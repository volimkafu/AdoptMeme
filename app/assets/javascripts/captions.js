$(document).ready( function () {

  var canvas = document.getElementById('catCanvas');
  var context = canvas.getContext('2d');

  var background = new Image();
  background.src = PET_IMAGE_INFO.amazonAWSUrl;

  // Make sure the image is loaded first otherwise nothing will draw.
  background.onload = function(){
      canvas.width = this.width;
      canvas.height = this.height;
      context.drawImage(background,0,0);
    }

  function render() {
    context.drawImage(background,0,0);
    var topText = $('#toptext').val()
    var bottomText = $('#bottomtext').val();

    var center_x = canvas.width / 2;
    var top_y = 50;
    var bottom_y = canvas.height - 50;

    context.textAlign = "center";
    context.font = "bold 60px Impact, sans-serif";
    context.fillStyle = "white";
    context.strokeStyle = "black";
    context.lineWidth = 3;
    context.fillText(topText, center_x, top_y);
    context.strokeText(topText, center_x, top_y);

    context.fillText(bottomText, center_x, bottom_y);
    context.strokeText(bottomText, center_x, bottom_y);
  }

  $('#toptext').on("keyup", function () {
    render();
  });

  $('#bottomtext').on("keyup", function () {
    render();
  });

});