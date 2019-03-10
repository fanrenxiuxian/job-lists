class AddWorkExperienceToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :work_experience, :string
  end
end
