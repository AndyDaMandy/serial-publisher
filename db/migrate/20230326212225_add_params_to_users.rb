class AddParamsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, unique: true
    add_column :users, :about, :text
    add_column :users, :favorite_quote, :text
  end
end
