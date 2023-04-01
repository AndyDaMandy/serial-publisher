class AddSlugToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :slug, :string
    add_index :stories, :slug, unique: true
  end
end
