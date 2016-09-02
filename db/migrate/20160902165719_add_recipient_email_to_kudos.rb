class AddRecipientEmailToKudos < ActiveRecord::Migration[5.0]
  def change
    add_column :kudos, :recipient_email, :string
  end
end
