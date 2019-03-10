class JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy,:clap, :cancel_clap]
  before_action :find_job, except: [:index,:new,:create]

  def index
    @jobs = Job.where(is_hidden: false).paginate(page: params[:page], per_page: 5)
  end

  def clap
    if !current_user.clapper_of?(@job)
      current_user.clap!(@job)
      flash[:notice] =  "已对该职位点赞"
    else
      flash[:alert] = "您已对该职位点赞过，无法再次点赞"
    end
    redirect_back(fallback_location: jobs_path)
  end

  def cancel_clap_disdain
    if params[:status] == "clap" #如果参数是clap，则执行取消点赞
      if current_user.clapper_of?(@job)
        current_user.cancel_clap!(@job)
        flash[:warning] =  "已取消对该职位点赞"
      else
        flash[:alert] =  "您未对该职位点赞，无法取消点赞"
      end
    elsif params[:status] == "disdain" #若参数是disdain，则执行取消点踩
      if current_user.disdainer_of?(@job)
        current_user.cancel_disdain!(@job)
        flash[:warning] =  "已取消对该职位点踩"
      else
        flash[:alert] =  "您未对该职位点踩，无法取消点踩"
      end
    end
    redirect_back(fallback_location: jobs_path)
  end

  def disdain
    if !current_user.disdainer_of?(@job)
      current_user.disdain!(@job)
      flash[:notice] =  "已对该职位点踩"
    else
      flash[:alert] = "您已对该职位点踩过，无法再次点踩"
    end
    redirect_back(fallback_location: jobs_path)
  end

  def show
    @job = Job.find params[:id]

    if @job.is_hidden
      redirect_to jobs_path
      flash[:warning]="该工作已消失"
    end
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
  end

  def update
    if @job.update job_params
      redirect_to jobs_path, notice:"更新成功"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
    flash[:alert] = "删除成功"
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :is_hidden, :wage_upper_bound, :wage_lower_bound, :contact_email)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end
