class Admin::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout 'admin'

  def index
    @messages = current_user.sender_messages
  end

  def show
    @message = Message.find params[:id]
  end

  def new
    @job = Job.find params[:job_id]
    @resume = Resume.find params[:resume_id]
    @message = Message.new
  end

  def create
    @job = Job.find params[:message][:job_id]
    @message = Message.new message_params
    if @message.save
      redirect_to admin_job_resumes_path(@job)
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
