$(document).ready(function(){
  
  // Message bar disapper
  if($('#message-bar').length) $('#message-bar').delay(7000).slideUp(500);
  
  // Sign in hover
  $('#sign-in').hover(
    function(){ $('#sign-in-message').fadeTo(0.0,0).animate({ opacity: 1.0, marginTop: '-=25px' },500); },
    function(){ $('#sign-in-message').animate({ opacity: 0.0, marginTop: '+=25px' }, 500); }
  );
  
  // Adding players by clicking on them in the form
  $('.player-stub.form').click(function(){
    var $checkbox = $(this).find(':checkbox');
    $checkbox.attr('checked', !$checkbox.attr('checked'));
    $(this).toggleClass('selected');
    return false;
  });
  
});