class Reply < ActiveRecord::Base
  belongs_to :clack

  def reply
  	users = User.all.pluck(:id)
  	feed_replies = Clack.includes(:user, :replies, :likes).where("user_id in (?)", users)
  	feed_replies
  end 

end
