class AddThumbsUps < ActiveRecord::Migration[5.0]
  def change
    create_table :thumbs_ups, id: false do |t|
      t.references :kudo
      t.references :user
      t.timestamps
    end
  end
end
