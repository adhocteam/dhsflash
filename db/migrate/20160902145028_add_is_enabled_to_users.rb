class AddIsEnabledToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_enabled, :boolean
    User.find_each do |user|
      user.is_enabled = true
      user.save!
    end
  end
end
