class AddInnapropriateCountToKudos < ActiveRecord::Migration[5.0]
  def change
    add_column :kudos, :inappropriate_count, :integer, default: 0
  end
end
