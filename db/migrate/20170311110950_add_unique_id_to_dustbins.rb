class AddUniqueIdToDustbins < ActiveRecord::Migration[5.0]
  def change
  add_column :dustbins, :unique_id, :integer
  end
end
