class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = current_user.receiver_messages
  end

  def show
    @message = Message.find params[:id]
  end

  def new
    @admin = User.find params[:user_id]
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.save
      redirect_to messages_path
      flash[:notice] = "已成功发送消息"
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :receiver_id, :sender_id, :job_id)
  end
end
