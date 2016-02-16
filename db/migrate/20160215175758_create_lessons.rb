class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :location
      t.text :description
      t.string :address
      t.string :yoga_category
      t.string :picture1
      t.string :picture2
      t.string :picture3
      t.integer :price
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
