class AddAttachmentToKudos < ActiveRecord::Migration[5.0]
  def change
    add_column :kudos, :attachment, :string
  end
end
