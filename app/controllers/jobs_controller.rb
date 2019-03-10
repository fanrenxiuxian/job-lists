class JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy,:collect,:cancel_collect]

  def index
    @jobs = Job.where(is_hidden: false)
  end

  def collect
    @job = Job.find(params[:id])
    if !current_user.collector_of?(@job)
      current_user.collect!(@job)
      flash[:notice] = "已将该职位加入到收藏列表"
    else
      flash[:warning] = "该职位已在您的收藏列表"
    end
    redirect_back(fallback_location: jobs_path)
  end

  def cancel_collect
    @job = Job.find(params[:id])
    if current_user.collector_of?(@job)
      current_user.cancel_collect!(@job)
      flash[:alert] = "已将该职位移出收藏列表"
    else
      flash[:warning] = "该职位已不在您的收藏列表"
    end
    redirect_back(fallback_location: jobs_path)
  end

  def show
    @job = Job.find params[:id]
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params

    if @job.save
      redirect_to jobs_path, notice:"创建成功"
    else
      render :new
    end
  end

  def edit
    @job = Job.find params[:id]
  end

  def update
    @job = Job.find params[:id]

    if @job.update job_params
      redirect_to jobs_path, notice:"更新成功"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find params[:id]
    @job.destroy
    redirect_to jobs_path
    flash[:alert] = "删除成功"
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :is_hidden, :wage_upper_bound, :wage_lower_bound, :contact_email)
  end
end
