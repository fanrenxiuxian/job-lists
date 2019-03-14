class JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy,:collect,:cancel_collect,:clap, :cancel_clap_disdain,:disdain,:claps,:collections]
  before_action :find_job, except: [:index,:new,:create,:claps,:collections,:search]
  before_action :validate_search_key, only: [:search]

  def index
    @jobs = Job.where(is_hidden: false).paginate(page: params[:page], per_page: 15)
  end

  #搜索职位
  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(distinct: true)
      @jobs = search_result.paginate(page: params[:page], per_page: 15)
    end
    render :index
  end

  #点赞的职位
  def claps
    @jobs = current_user.job_claps.paginate(page: params[:page],per_page: 10)
  end

  #收藏的职位
  def collections
    @jobs = current_user.collected_jobs.paginate(page: params[:page],per_page: 10)
  end

  #对职位进行点赞
  def clap
    if !current_user.clapper_of?(@job)
      current_user.clap!(@job)
      flash[:notice] =  "已对该职位点赞"
    else
      flash[:alert] = "您已对该职位点赞过，无法再次点赞"
    end
    redirect_back(fallback_location: jobs_path)
  end

  #对职位进行取消点赞或点踩
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

  #对职位进行点踩
  def disdain
    if !current_user.disdainer_of?(@job)
      current_user.disdain!(@job)
      flash[:notice] =  "已对该职位点踩"
    else
      flash[:alert] = "您已对该职位点踩过，无法再次点踩"
    end
    redirect_back(fallback_location: jobs_path)
  end

  #对职位进行收藏
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

  #对职位进行取消收藏
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


  protected

  #取到params[:q]的内容并去掉非法的内容
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :is_hidden, :wage_upper_bound, :wage_lower_bound, :contact_email, :educational_background, :work_experience)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end
