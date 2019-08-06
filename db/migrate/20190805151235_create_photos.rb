class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string  :image, null: false

      t.timestamps null: false
    end
    add_index :photos, :user_id
  end
end
