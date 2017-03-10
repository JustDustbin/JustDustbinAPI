class CreateDustbins < ActiveRecord::Migration[5.0]
  def change
    create_table :dustbins do |t|
      t.string :name
      t.string :worker
      t.string :city
      t.string :support_number
      t.integer :status
      t.decimal :gps_latitude, :precision => 10, :scale => 6
      t.decimal :gps_longitude, :precision => 10, :scale => 6
      t.timestamps
    end
  end
end
