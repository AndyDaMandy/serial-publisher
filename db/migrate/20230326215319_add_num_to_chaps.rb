class AddNumToChaps < ActiveRecord::Migration[7.0]
  def change
    add_column :chapters, :chapter_number, :integer
  end
end
