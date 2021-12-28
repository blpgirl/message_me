class MessagesController < ApplicationController
  before_action :require_user
  # Remove the token verification for this controller just to be able to move forward with the broadcast
  # skip_before_action :verify_authenticity_token
  # made it work in javascripts/packs/application.js import { csrfToken } from "@rails/ujs"


  def create
    # current user method is in the ApplicationController
    message = current_user.messages.build(message_params)
    if message.save
      #redirect_to root_path
      # Let all the clients know that a new message has been send to the chat for real time refresh
      # rails generate channel chatroom_channel
      # mod_message is the attribute I have to call to retrieve the message. Can be called whatever
      ActionCable.server.broadcast("chatroom_channel", { mod_message: message_render(message) })
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  # this is to aply the _message.html.erb partial to the text submitted in the index form
  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end
end
