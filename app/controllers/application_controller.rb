class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    jobs_path
  end

  def require_is_admin
    unless current_user.admin?
      redirect_to jobs_path
      flash[:alert] = '您不是管理员，不能进入。'
    end
  end
end
