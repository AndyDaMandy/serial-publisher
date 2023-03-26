class AddForeignToChapters < ActiveRecord::Migration[7.0]
  def change
    add_reference :chapters, :user
  end
end
