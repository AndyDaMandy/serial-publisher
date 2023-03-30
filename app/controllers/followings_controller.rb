class FollowingsController < ApplicationController

  def create
    @following = current_user.following.build(:follower_id => params[:follower_id])
    if @@following.save
      flash[:notice] = "You are now following them"
      redirect_to root_url
    else
      flash[:error] = "Unable to follow them"
      redirect_to root_url
    end
  end

  def destroy
    @following = current_user.following.find(params[:id])
    @ollowing.destroy
    flash[:notice] = "Removed following"
    redirect_to current_user
  end


end
