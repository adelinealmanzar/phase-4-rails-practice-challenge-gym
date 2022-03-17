class AddClientToMembership < ActiveRecord::Migration[6.1]
  def change
    add_reference :memberships, :client, null: false, foreign_key: true
  end
end
