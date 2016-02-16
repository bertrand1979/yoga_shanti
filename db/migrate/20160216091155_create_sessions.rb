class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.boolean :conf_status
      t.date :starts_at
      t.references :user, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
