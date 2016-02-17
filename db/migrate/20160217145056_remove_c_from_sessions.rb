class RemoveCFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :conf_status, :string
  end
end
