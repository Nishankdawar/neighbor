class AddLatLngToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lat, :decimal
    add_column :users, :lng, :decimal
  end
end
