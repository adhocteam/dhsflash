class AddKudoCountsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :kudos_sent, :integer, default: 0
    add_column :users, :kudos_received, :integer, default: 0
    User.all.each do |u|
      u.update_attributes(
        kudos_sent: Kudo.where(creator_id: u.id).count,
        kudos_received: Kudo.where(recipient_id: u.id).count
      )
    end
  end
end
