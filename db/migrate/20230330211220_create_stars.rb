class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      t.references :story, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
