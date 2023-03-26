class AddForeignToChapters < ActiveRecord::Migration[7.0]
  def change
    add_reference :chapters, :user, foreign_key: true
  end
end
