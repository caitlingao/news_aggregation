class AddLoginToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :login, :string, limit: 100
  end
end
