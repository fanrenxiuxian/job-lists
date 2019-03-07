class ResumesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]

  def new
    @job = Job.find params[:id]
    @resume = Resume.new
  end

  def create
    binding.pry
    @job = Job.find params[:resume][:job_id]
    @resume = Resume.new resume_params
    @resume.job = @job
    @resume.user = current_user

    if @resume.save
      redirect_to job_path(@job)
      flash[:notice] = "已成功发送简历"
    else
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:content)
  end

end
