class AddStartDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :start_date, :string
  end
end
