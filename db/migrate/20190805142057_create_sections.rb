class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.string :name, null: false
      t.integer :sort, default: 0, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :sections, :sort
    add_index :sections, :deleted_at
  end
end
