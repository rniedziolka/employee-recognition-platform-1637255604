class CreateOnlineCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :online_codes do |t|
      t.string :code, index: { unique: true }
      t.integer :status, default: 0
      t.references :reward, null: false, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
