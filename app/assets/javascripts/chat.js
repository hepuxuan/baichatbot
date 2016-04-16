
$( document ).ready(function() {
  var KEY = 'f765df6a-112f-4f20-ae65-424467831991',
    d, h, m,
    i = 0;
  var $messages = $('.messages-content');
      
  $messages.mCustomScrollbar();
  function updateScrollbar() {
    $messages.mCustomScrollbar("update").mCustomScrollbar('scrollTo', 'bottom', {
      scrollInertia: 10,
      timeout: 0
    });
  }

  function setDate(){
    d = new Date()
    if (m != d.getMinutes()) {
      m = d.getMinutes();
      $('<div class="timestamp">' + d.getHours() + ':' + m + '</div>').appendTo($('.message:last'));
    }
  }

  function insertMessage() {
    var msg = $('.message-input').val();
    if ($.trim(msg) == '') {
      return false;
    }
    $('<div class="message message-personal">' + msg + '</div>').appendTo($('.mCSB_container')).addClass('new');
    setDate();
    $('.message-input').val(null);
    updateScrollbar();
    callSimSim(msg).then(function(messageResp) {
      addMessage(messageResp.response);
    });
  }

  function callSimSim(message) {
    var url = `/message?message=${encodeURI(message)}`;
    return $.getJSON({
        url: url,
        contentType: "application/json",
    });
  }

  function addMessage(message) {
    if ($('.message-input').val() != '') {
      return false;
    }
    $('<div class="message loading new"><figure class="avatar"><img src="/assets/bai.png" /></figure><span></span></div>').appendTo($('.mCSB_container'));
    updateScrollbar();

    $('.message.loading').remove();
    $('<div class="message new"><figure class="avatar"><img src="/assets/bai.png" /></figure>' + message + '</div>').appendTo($('.mCSB_container')).addClass('new');
    setDate();
    updateScrollbar();
    i++;

  }

  $('.message-submit').click(function() {
    insertMessage();
  });

  $(window).on('keydown', function(e) {
    if (e.which == 13) {
      insertMessage();
      return false;
    }
  })
});