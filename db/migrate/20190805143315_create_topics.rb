class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.integer  :user_id, null: false
      t.integer  :node_id, null: false
      t.string   :title, null: false
      t.text     :body, null: false
      t.string   :node_name
      t.string   :who_deleted
      t.integer  :grade, default: 0
      t.integer  :sort, default: 0
      t.string   :summary, limit: 500
      t.string   :banner
      t.datetime :deleted_at
      t.datetime :closed_at

      t.timestamps null: false
    end

    add_index :topics, :grade
    add_index :topics, [:node_id, :deleted_at]
    add_index :topics, :user_id
  end
end
