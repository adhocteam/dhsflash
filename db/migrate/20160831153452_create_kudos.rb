class CreateKudos < ActiveRecord::Migration[5.0]
  def change
    create_table :kudos do |t|
      t.text :message
      t.references :user
      t.timestamps
    end
  end
end
