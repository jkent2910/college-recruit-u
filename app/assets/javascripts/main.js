var captionLength = 0;
var caption = 'fun, easy, and social';

$(document).ready(function() {
  setInterval('cursorAnimation()', 600);
  captionEl = $('#caption');
  type();
});


function erase() {
  captionEl.html(caption.substr(0, captionLength--));
  if(captionLength >= 0) {
    setTimeout('erase()', 50);
  } else {
    captionLength = 0;
    caption = '';
  }
}


function type() {
  captionEl.html(caption.substr(0, captionLength++));
  if(captionLength < caption.length+1) {
    setTimeout('type()', 50);
  } else {
    captionLength = 0;
    caption = '';
  }
}
function cursorAnimation() {
  $('#cursor').animate({
    opacity: 0 
  }, 'fast', 'swing').animate({
    opacity: 1
  }, 'fast', 'swing');
}