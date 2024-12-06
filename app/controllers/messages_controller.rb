class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.find_by(id: params[:group_id])  # Assuming you're working within a specific group
    @sent_messages = Message.where(posted_by: current_user.id, group_id: @group&.id)
    @received_messages = Message.where(recipient_id: current_user.id, group_id: @group&.id)
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
