class AddAttachmentToResume < ActiveRecord::Migration[5.2]
  def change
    add_column :resumes, :attachment, :string
  end
end
