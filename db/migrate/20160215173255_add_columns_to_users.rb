class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :birth_date, :date
    add_column :users, :description, :text
    add_column :users, :start_year, :date
    add_column :users, :picture, :string
  end
end
