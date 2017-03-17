class AddFollowercountToUser < ActiveRecord::Migration
  def change
  	add_column :users,:followercount,:integer, default: 0
  	add_column :users,:followeecount,:integer, default: 0
  end
end
