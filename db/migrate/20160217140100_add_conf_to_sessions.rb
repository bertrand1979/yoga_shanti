class AddConfToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :conf_status, :string, :default => false
  end
end
