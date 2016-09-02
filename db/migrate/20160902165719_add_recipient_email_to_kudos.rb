class AddRecipientEmailToKudos < ActiveRecord::Migration[5.0]
  def change
    begin
      add_column :kudos, :recipient_email, :string
    rescue
    end
  end
end
