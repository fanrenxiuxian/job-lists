class ResumesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :index]

  def index
    @resumes = current_user.resumes
  end

  def new
    @job = Job.find params[:job_id]
    @resume = Resume.new
  end

  def create
    @job = Job.find params[:job_id]
    @resume = Resume.new resume_params
    @resume.job = @job
    @resume.user = current_user

    if @resume.save
      redirect_to job_path(@job)
      flash[:notice] = "成功发送简历"
    else
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end
end
