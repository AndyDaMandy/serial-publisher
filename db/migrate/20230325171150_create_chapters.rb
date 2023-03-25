class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.text :title
      t.text :description
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
