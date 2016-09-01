class AddNotificationPreferences < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_frequency, :string
    add_column :users, :notification_method, :string
    add_column :users, :mobile_number, :string
  end
end
