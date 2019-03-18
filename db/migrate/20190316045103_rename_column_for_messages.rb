class RenameColumnForMessages < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :receiver_email, :receiver_id
    rename_column :messages, :sender_email, :sender_id
  end
end
