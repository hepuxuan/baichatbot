
var messageService = (function () {
  var service = {
    get: function(message) {
      var url = message ? '/message?message=' + encodeURI(message) : '/message';
      return $.getJSON({
          url: url,
          contentType: "application/json",
      }).then(function (Resp) {
        return Resp.response;
      });
    },
  };

  return service;
})();


$( document ).ready(function() {
  var ADD_MESSAGE_INTERVAL = 30 * 1000;
  var DISCONNECT_THRESHOLD = 2 * 60 * 1000;
  var disconnect = false;
  var d;
  var h;
  var m;
  var i = 0;
  var $messages = $('.messages-content');
  var addMessageEvent = new Event('addMessage');
  var insertMessageEvent = new Event('InsertMessage');

  $messages.mCustomScrollbar();
  addMessage('hi buddy, what\'s up');
  var lastInputTime = new Date();
  var lastOutputTime = new Date();

  (function initDocument() {
    document.addEventListener('addMessage', function (e) {
      updateScrollbar();
      setDate();
      lastOutputTime = new Date();
    }, false);

    document.addEventListener('InsertMessage', function (e) {
      updateScrollbar();
      setDate();
      lastInputTime = new Date();
    }, false);

    $('.message-submit').click(function() {
      insertMessage();
    });

    $(window).on('keydown', function(e) {
      if (e.which == 13) {
        insertMessage();
        return false;
      }
    });

    setInterval(function() {
      var idle =  (new Date() - lastInputTime) > ADD_MESSAGE_INTERVAL;
      var preConnect = !disconnect;
      disconnect = (new Date() - lastInputTime) > DISCONNECT_THRESHOLD;
      if (preConnect && disconnect) {
        addMessage('See ya next time, Bye!');
      } else if (!disconnect && idle && (new Date() - lastOutputTime) > ADD_MESSAGE_INTERVAL) {
        messageService.get().then(function (message) {
          addMessage(message);
          i++;
        });
      }
    }, 1 * 1000);
  })();

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
    document.dispatchEvent(addMessageEvent);
    $('.message-input').val(null);
    messageService.get(msg).then(function(message) {
      addMessage(message);
    });
    document.dispatchEvent(insertMessageEvent);
  }
  function addMessage(message) {
    if ($('.message-input').val() != '') {
      return false;
    }
    var imageSrc = $('#bai-icon').children().attr('src');
    $('<div class="message loading new"><figure class="avatar"><img src="'+imageSrc+'"/></figure><span></span></div>').appendTo($('.mCSB_container'));

    $('.message.loading').remove();
    $('<div class="message new"><figure class="avatar"><img src="'+imageSrc+'"/></figure>' + message + '</div>').appendTo($('.mCSB_container')).addClass('new');
    document.dispatchEvent(addMessageEvent);
  }
});
