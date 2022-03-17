class AddGymToMembership < ActiveRecord::Migration[6.1]
  def change
    add_reference :memberships, :gym, null: false, foreign_key: true
  end
end
