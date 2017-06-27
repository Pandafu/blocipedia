class RemoveWikisidAndWikisIndex < ActiveRecord::Migration
  def change
    remove_index :wikis, :wikis_id
    remove_column :wikis, :wikis_id
  end
end
