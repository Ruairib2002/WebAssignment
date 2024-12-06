class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipient = User.find(params[:user_id])
    @message = Message.new
  end

  def create
    @recipient = User.find(params[:user_id])
    @message = Message.new(message_params.merge(user_id: current_user.id, recipient_id: @recipient.id))

    if @message.save
      redirect_to profile_path(@recipient), notice: 'Message sent successfully.'
    else
      redirect_to profile_path(@recipient), alert: 'Failed to send message.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:message_content)
  end
end
