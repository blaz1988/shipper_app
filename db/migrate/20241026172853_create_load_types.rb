class CreateLoadTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :load_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
