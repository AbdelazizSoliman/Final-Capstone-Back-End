class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialization
      t.string :picture
      t.decimal :price
      t.integer :phone_number
      t.time :time_start
      t.time :time_end

      t.timestamps
    end
  end
end
