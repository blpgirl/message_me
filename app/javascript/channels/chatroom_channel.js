import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    //alert(data.mod_message);
    $('#message-container').append(data.mod_message);
    scroll_bottom(); // this one is in custom.js in javascripts
    $('#message_body').val('');
  }
});
