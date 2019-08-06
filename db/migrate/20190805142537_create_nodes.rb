class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.string  :name, null: false
      t.string  :summary
      t.integer :section_id, null: false
      t.integer :sort, default: 0, null: false
      t.integer :topics_count, default: 0, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :nodes, :section_id
    add_index :nodes, :sort
    add_index :nodes, :deleted_at
  end
end
