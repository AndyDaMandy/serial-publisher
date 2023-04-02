class AddEnunToUsersAndChapters < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer
    add_column :chapters, :status, :integer
    add_column :stories, :status, :integer
  end
end
