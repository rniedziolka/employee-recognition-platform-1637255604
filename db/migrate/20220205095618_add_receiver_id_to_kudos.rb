class AddReceiverIdToKudos < ActiveRecord::Migration[6.1]
  def change
    add_column :kudos, :receiver_id, :integer
    add_index :kudos, :receiver_id
  end
end
