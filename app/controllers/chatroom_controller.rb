class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @message = Message.new
    # custom display is a scope defined in the model to only get the last 20 messages created
    # only when the page is loaded, since i submit messages with ajax it doesn't work then
    @messages = Message.custom_display

    #@messages = Message.all
  end
end
