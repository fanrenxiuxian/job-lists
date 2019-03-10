class Job < ApplicationRecord
  validates :title, presence: true
  has_many :job_collections
  has_many :job_collectors, through: :job_collections, source: :user
end
