class RemoveStartYearFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :start_year, :string
  end
end
