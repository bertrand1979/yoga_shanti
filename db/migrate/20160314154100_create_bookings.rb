class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :session, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
