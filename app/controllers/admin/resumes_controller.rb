class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  def index
    @job = Job.find params[:job_id]
    @resumes = @job.resumes.paginate(page: params[:page], per_page: 5)
  end
end
