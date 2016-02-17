class AddCToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :conf_status, :boolean, :default => false
  end
end
