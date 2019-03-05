class AddIsHiddenToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :is_hidden, :boolean, default: false
  end
end
