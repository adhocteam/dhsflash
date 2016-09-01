class AddNotificationPreferences < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_frequency, :string, default: 'all'
    add_column :users, :notification_method, :string, default: 'email'
    add_column :users, :mobile_number, :string

    User.all.each do |user|
      user.update_attributes(
        notification_frequency: 'all',
        notification_method: 'email'
      )
    end
  end
end
