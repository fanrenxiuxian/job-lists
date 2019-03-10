class AddEducationalBackgroundToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :educational_background, :string
  end
end
