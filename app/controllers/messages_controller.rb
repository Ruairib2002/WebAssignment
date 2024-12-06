class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_messages = Message.where(group_id: current_user.groups.pluck(:id))
    @sent_messages = Message.where(posted_by: current_user.id)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params.merge(posted_by: current_user.id))

    if @message.save
      redirect_to dashboard_path, notice: 'Message sent successfully.'
    else
      redirect_to dashboard_path, alert: 'Failed to send message.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:message_content, :group_id, :recipient_id)
  end
end
