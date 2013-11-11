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
    var topText = $('#toptext').val().toUpperCase();
    var bottomText = $('#bottomtext').val().toUpperCase();;

    var center_x = canvas.width / 2;
    var bottom_y = canvas.height - 50;

    context.textAlign = "center";
    context.font = "bold 60px Impact, sans-serif";
    context.lineWidth = 3;
    context.fontsize = 75;
    context.fillStyle = "white";
    context.strokeStyle = "black";

    drawTopText(topText, center_x, 65)

    context.lineWidth = 2.5;
    context.fontsize = 75;
    drawBottomText(bottomText, center_x)
  }

  function drawText(text, xpos, ypos) {
    var startText = text.slice(0,30)
    context.font = "bold "+context.fontsize+"px Impact, sans-serif";
    while (context.measureText(startText).width > (canvas.width-20)) {
      ypos = ypos - 2;
      context.fontsize = context.fontsize - 4;
      context.lineWidth = context.lineWidth - 0.1;
      context.font = "bold "+context.fontsize+"px Impact, sans-serif";
    }

    context.fillText(startText, xpos, ypos);
    context.strokeText(startText, xpos, ypos);
  }

  function drawTopText(text, xpos, ypos) {
    drawText(text.slice(0,30), xpos, ypos)
    if (text.slice(30) !== "") {
      drawTopText(text.slice(30), xpos, ypos+40);
    }
  }

  function drawBottomText(text, xpos) {
    var lines = Math.ceil(text.length/30);
    ypos = canvas.height - lines*30;
    for (var i=0; i < lines; i++) {
      drawText(text.slice(i*30, (i+1)*30), xpos, ypos)
      ypos += 40;
    }
  }

  $('#toptext').on("keyup", function () {
    render();
  });

  $('#bottomtext').on("keyup", function () {
    render();
  });

});