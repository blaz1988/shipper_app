class CreateRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :routes do |t|
      t.string :origin
      t.string :destination

      t.timestamps
    end
  end
end
