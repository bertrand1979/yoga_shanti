class AddMaxnumberToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :maxnumber, :integer
  end
end
