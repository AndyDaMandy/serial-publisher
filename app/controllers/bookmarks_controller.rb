class BookmarksController < ApplicationController
    before_action :find_story  
    before_action :find_bookmark, only: [:destroy]
    
    def create
        if already_bookmarked?
            flash[:notice] = "You can't bookmark more than once"
        else
            @story.bookmarks.create(user_id: current_user.id)
        end
        redirect_to story_path(@story)
    end  

    def destroy
        if already_bookmarked? == false
          flash[:notice] = "Cannot remove bookmark"
        else
          @bookmark.destroy
        end
        redirect_to story_path(@story)
      end

  private  
  def find_story
    @story = Story.friendly.find(params[:story_id])
  end
  def find_bookmark
    @bookmark = @story.bookmarks.find(params[:id])
  end
  def already_bookmarked?
    Bookmark.where(user_id: current_user.id, story_id:
    params[:story_id]).exists?
  end
end
