class ChangeColumnForMessages < ActiveRecord::Migration[5.2]
  def change
    change_column :messages, :receiver_id, :integer
    change_column :messages, :sender_id, :integer
  end
end
