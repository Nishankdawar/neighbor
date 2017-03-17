class AddLikecountToClack < ActiveRecord::Migration
  def change
  	add_column :clacks,:likecount,:integer,default: 0
  end
end
