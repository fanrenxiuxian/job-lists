class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy, :show, :publish, :hide]
  before_action :require_is_admin
  layout 'admin'

  def index
    @user = current_user
    @jobs = Job.all.paginate(page: params[:page], per_page: 15)
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params

    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def show
    @job = Job.find params[:id]
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

  def destroy
    @job = Job.find params[:id]
    @job.destroy
    redirect_to admin_jobs_path
    flash[:alert] = "已删除这个招聘信息"
  end

  def require_is_admin
    if !current_user.admin?
      redirect_to jobs_path
      flash[:alert] = "您不是管理员，不能进入。"
    end
  end

  def publish
    @job = Job.find params[:id]
    @job.update(is_hidden: false)
    redirect_to admin_jobs_path
  end

  def hide
    @job = Job.find params[:id]
    @job.update(is_hidden: true)
    redirect_to admin_jobs_path
  end

  private
  def job_params
    params.require(:job).permit(:title, :description, :is_hidden, :wage_upper_bound, :wage_lower_bound, :contact_email, :educational_background, :work_experience)
  end
end
