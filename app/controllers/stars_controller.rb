# frozen_string_literal: true

# For "liking" a page with a start
class StarsController < ApplicationController
  before_action :find_story
  before_action :find_star, only: [:destroy]

  def create
    if already_starred?
      flash[:notice] = "You can't star more than once"
    else
      @story.stars.create(user_id: current_user.id)
    end
    redirect_to story_path(@story)
  end

  def destroy
    if already_starred? == false
      flash[:notice] = "Cannot remove star"
    else
      @star.destroy
    end
    redirect_to story_path(@story)
  end

  private

  def find_story
    @story = Story.friendly.find(params[:story_id])
  end

  def find_star
    @star = @story.stars.find(params[:id])
  end

  def already_starred?
    Star.where(user_id: current_user.id, story_id:
    params[:story_id]).exists?
  end
end
