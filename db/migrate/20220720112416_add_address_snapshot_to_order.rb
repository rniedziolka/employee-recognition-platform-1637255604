class AddAddressSnapshotToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address_snapshot, :text
  end
end
