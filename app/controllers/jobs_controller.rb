class JobsController < ApplicationController

  def index
    @jobs = Job.find_each(batch_size: 100)
  end
end
