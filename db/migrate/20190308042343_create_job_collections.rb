class CreateJobCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :job_collections do |t|
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
