class ThumbsUpsNew < ApplicationRecord
end

class RebuildThumbsUps < ActiveRecord::Migration[5.0]
  def change
    create_table :thumbs_ups_news do |t|
      t.references :kudo
      t.references :user
      t.timestamps
    end
    ThumbsUp.all.each do |old|
      ThumbsUpsNew.create(
        kudo_id: old.kudo_id,
        user_id: old.user_id
      )
    end
    drop_table :thumbs_ups
    rename_table :thumbs_ups_news, :thumbs_ups
  end
end
