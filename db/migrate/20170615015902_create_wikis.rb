class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.boolean :private
      t.integer :user_id
      t.index :user_id


      t.timestamps null: false
    end
  end
end
