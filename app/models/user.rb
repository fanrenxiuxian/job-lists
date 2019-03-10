class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :job_collections
  has_many :collected_jobs, through: :job_collections, source: :job

  def admin?
    is_admin
  end

  def collector_of?(job)
    self.collected_jobs.include?(job)
  end

  def collect!(job)
    self.collected_jobs.push(job)
  end

  def cancel_collect!(job)
    self.collected_jobs.delete(job)
  end
end
