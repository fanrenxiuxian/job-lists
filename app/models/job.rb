class Job < ApplicationRecord
  validates :title, presence: true

  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality:{ greater_than: 0 }
  validates :wage_upper_bound, numericality:{ greater_than: :wage_lower_bound }

  has_many :resumes

  has_many :votes #点赞
  has_many :clappers, through: :votes, source: :user

  has_many :disdains #踩
  has_many :disdainers, through: :disdains, source: :user
end
