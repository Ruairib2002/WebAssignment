class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @message = @group.messages.new(message_params.merge(user_id: current_user.id))

    if @message.save
      redirect_to group_path(@group)
    else
      render 'groups/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:message_content)
  end
end
