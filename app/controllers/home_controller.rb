class HomeController < ApplicationController
  
  before_action :authenticate_user

  def index
    @clacks = current_user.feed
  end

  def create_clack
    current_user.clacks.create(content: params[:content])
    return redirect_to '/'
  end

  def like
    clack = Clack.new
    clack_id = params[:clack_id]
    like = current_user.likes.where(clack_id: clack_id).first
    if like
      like.destroy
    else
      current_user.likes.create(clack_id: clack_id)
    end
    redirect_to '/'
  end

  # def follow
  #   followee_id = params[:followee_id]
  #   follow_mapping = FollowMapping.where(:follower_id => current_user.id, :followee_id => followee_id).first
  #   unless follow_mapping
  #     follow_mapping = FollowMapping.where(:follower_id => current_user.id, :followee_id => followee_id)
  #   else
  #     follow_mapping.destroy
  #   end
  #   return redirect_to '/users'
  # end

  def users
    @users = User.find(session[:user_id])
    @all_users = User.all
    @followlist = FollowMapping.where(:follower_id => session[:user_id])
    puts '','','','',''
    @followlist.each do |f|
      print f.follower_id,' ',f.followee_id
    end  
    puts '','','','',''
  end

 def add_follow
  followeeid = params[:tofollowuserid].to_i
  follow = FollowMapping.new
  follow.followee_id = followeeid
  follow.follower_id = session[:user_id]
  user = User.find(followeeid)
  User.where(:username => user.username).first.followercount += 1
  user.save
  user = User.find(session[:user_id])
  User.where(:username => user.username).first.followercount += 1
  user.save
  follow.save
  redirect_to '/users'
end

def remove_follow
  followerid = params[:tofollowuserid].to_i
  follow = FollowMapping.where(:followee_id => followerid)
  user = User.find(followerid)
  user.followercount -= 1
  user.save
  user = User.find(session[:user_id])
  user.followeecount -= 1
  user.save
  follow.destroy
  redirect_to '/users'
end

  def followers
    @users = current_user.followercount
  end

  def followees
    @users = current_user.followeecount
  end
end
