class User < ActiveRecord::Base

	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	    obj.city    = geo.city
	    obj.zipcode = geo.postal_code
	    obj.country = geo.country_code
	  end
	end
	after_validation :reverse_geocode

	has_many :clacks
	has_many :likes
	has_many :follower_mappings, class_name: 'FollowMapping', foreign_key: 'follower_id'
	has_many :followee_mappings, class_name: 'FollowMapping', foreign_key: 'followee_id'
	has_many :followers, through: :follower_mappings
	has_many :followees, through: :followee_mappings
    acts_as_mappable :lat_column_name => :lat, :lng_column_name => :lng


	def feed
		users = User.all.pluck(:id)
		feed_clacks = Clack.includes(:user, :likes).where("user_id in (?)", users)
		feed_clacks.order(created_at: :desc)
	end
end