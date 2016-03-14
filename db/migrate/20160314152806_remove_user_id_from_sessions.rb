class RemoveUserIdFromSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :user_id
  end
end
