class AddCategoryToKudos < ActiveRecord::Migration[5.0]
  def change
    add_column :kudos, :category, :string
  end
end
