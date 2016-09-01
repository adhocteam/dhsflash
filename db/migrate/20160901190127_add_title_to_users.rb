class AddTitleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :title, :string
    User.where(title: nil).each do |user|
      user.update_attributes(title: Faker::Name.title)
    end
  end
end
