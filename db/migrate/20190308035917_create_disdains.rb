class CreateDisdains < ActiveRecord::Migration[5.2]
  def change
    create_table :disdains do |t|
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
