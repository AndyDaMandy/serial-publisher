class AddContentToChapters < ActiveRecord::Migration[7.0]
  def change
    add_column :chapters, :content, :text
  end
end
