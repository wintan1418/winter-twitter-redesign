class AddOpinionToUser < ActiveRecord::Migration[6.1]
  def change
    add column :opinions, user_id, :integer
  end
end
