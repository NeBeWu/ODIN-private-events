class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.datetime :date
      t.text :location
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
