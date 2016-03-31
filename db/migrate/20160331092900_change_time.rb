class ChangeTime < ActiveRecord::Migration
  def change
    change_column :sessions, :starts_at, :datetime
  end
end
