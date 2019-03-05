class Admin::JobsController < ApplicationController

  def index
    @jobs = Job.all
  end

  def edit
    @job = Job.find params[:id]
  end

  def update
    @job = Job.find params[:id]

    if @job.update job_params
      redirect_to admin_jobs_path
    else
      render :edit
    end
  end


  private
  def job_params
    params.require(:job).permit(:title, :description)
  end
end
