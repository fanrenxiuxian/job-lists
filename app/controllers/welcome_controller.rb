class WelcomeController < ApplicationController
  layout 'welcome'
  def index
    flash[:notice] = '~~乐聘欢迎您~~'
  end
end
