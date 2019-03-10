class ApplicationController < ActionController::Base
  def require_is_admin
    if !current_user.admin?
      redirect_to jobs_path
      flash[:alert] = "您不是管理员，不能进入。"
    end
  end
end
