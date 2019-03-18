class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :receiver_email
      t.string :sender_email

      t.timestamps
    end
  end
end
