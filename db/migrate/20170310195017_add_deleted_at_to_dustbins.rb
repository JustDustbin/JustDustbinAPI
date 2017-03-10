class AddDeletedAtToDustbins < ActiveRecord::Migration[5.0]
  def change
    add_column :dustbins, :deleted_at, :datetime
    add_index :dustbins, :deleted_at
  end
end
