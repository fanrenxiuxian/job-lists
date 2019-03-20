class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :job_collections
  has_many :collected_jobs, through: :job_collections, source: :job
  has_many :votes
  has_many :job_claps, through: :votes, source: :job

  has_many :resumes

  has_many :disdains
  has_many :job_disdains, through: :disdains, source: :job


  has_many :sender_messages, class_name:"Message", foreign_key: "sender_id"
  has_many :receiver_messages, class_name:"Message", foreign_key: "receiver_id"






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

  def clapper_of?(job)
    self.job_claps.include?(job)
  end

  def clap!(job)
    self.job_claps.push(job)
  end

  def cancel_clap!(job)
    self.job_claps.delete(job)
  end

  def disdainer_of?(job)
    self.job_disdains.include?(job)
  end

  def disdain!(job)
    self.job_disdains.push(job)
  end

  def cancel_disdain!(job)
    self.job_disdains.delete(job)
  end

end
