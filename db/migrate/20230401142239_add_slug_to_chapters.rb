class AddSlugToChapters < ActiveRecord::Migration[7.0]
  def change
    add_column :chapters, :slug, :string
    add_index :chapters, :slug, unique: true
  end
end
