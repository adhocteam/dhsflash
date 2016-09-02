class RemoveThumbsAndFlags < ActiveRecord::Migration[5.0]
  def change
    drop_table :thumbs_ups
    remove_column :kudos, :inappropriate_count
  end
end
