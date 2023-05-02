# frozen_string_literal: true

# For following users
class FollowingsController < ApplicationController

  def create
    @following = current_user.following.build(follower_id: params[:follower_id])
    if @following.save
      flash[:notice] = 'You are now following them'
    else
      flash[:error] = 'Unable to follow them'
    end
    redirect_to root_url
  end

  def destroy
    @following = current_user.following.find(params[:id])
    @following.destroy
    flash[:notice] = 'Removed following'
    redirect_to current_user
  end

end
