class Job < ApplicationRecord
  validates :title, presence: true
  has_many :votes #点赞
  has_many :clappers, through: :votes, source: :user

  has_many :disdains #踩
  has_many :disdainers, through: :disdains, source: :user
end
