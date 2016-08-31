class AddRecipientToKudos < ActiveRecord::Migration[5.0]
  def change
    rename_column :kudos, :user_id, :creator_id
    add_column :kudos, :recipient_id, :integer
    add_index :kudos, [:recipient_id]
  end
end
