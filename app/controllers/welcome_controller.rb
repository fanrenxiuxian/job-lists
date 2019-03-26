class WelcomeController < ApplicationController
  layout 'welcome'
  def index
    flash[:notice] = 'Good Morning'
  end
end
