class CreateBids < ActiveRecord::Migration[7.1]
  def change
    create_table :bids do |t|
      t.decimal :price
      t.references :carrier, null: false, foreign_key: true
      t.references :route, null: false, foreign_key: true
      t.references :load_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
