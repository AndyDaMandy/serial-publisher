class StoriesController < ApplicationController
  before_action :set_story, only: %i[ show edit update destroy ]
  before_action :get_chapters, only: %i[ show ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]

  # GET /stories or /stories.json
  def index
    if user_signed_in?
      if params[:filter] == 'my_stories'
        @pagy, @stories = pagy(current_user.stories.order("created_at DESC"))
      elsif params[:filter] == 'bookmarked'
        arr = []
        current_user.bookmarks.each do |bookmark|
          arr << bookmark.story_id
        end
        @pagy, @stories = pagy(Story.where(status: "published").and(Story.where(id: arr)).order("created_at DESC"))
       #@stories = Story.where(status: "published").order("created_at DESC")
       #@stories = @stories.each.bookmarked_by(current_user)
       #@stories.all
       # @bookmarks = @stories.bookmarks
       # @stories = @stories.where()
      else
       @pagy, @stories = pagy(Story.where(status: "published").or(Story.where(user_id: current_user.id)).order("created_at DESC"))
      end
    else
      @pagy, @stories = pagy(Story.where(status: "published").order("created_at DESC"))
    end
    #@stories = Story.all.order("created_at DESC")
  end

  # GET /stories/1 or /stories/1.json
  def show
    if user_signed_in?
      if @story.status != 'published' && @story.user != current_user
        redirect_to story_path, alert: "You do not have access to this page"
      end
    else
      if @story.status != 'published'
        redirect_to story_path, alert: "You do not have access to this page"
      end
    end
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories or /stories.json
  def create
    @story = Story.new(story_params.except(:tags))
    create_or_delete_stories_tags(@story, params[:story][:tags])
    @story.user = current_user

    respond_to do |format|
      if @story.save
        format.html { redirect_to story_url(@story), notice: "Story was successfully created." }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1 or /stories/1.json
  def update
    create_or_delete_stories_tags(@story, params[:story][:tags])
    respond_to do |format|
      if @story.update(story_params.except(:tags))
        format.html { redirect_to story_url(@story), notice: "Story was successfully updated." }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1 or /stories/1.json
  def destroy
    @story.destroy

    respond_to do |format|
      format.html { redirect_to stories_url, notice: "Story was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def bookmarked_by(user)
    return false unless bookmarked?

    bookmarks.any? {|b| b.user == user }
  end   

    def check_status(story)
      if story.status == 'published'
        true
      else
        false
      end
    end

    def create_or_delete_stories_tags(story, tags)
      story.taggables.destroy_all
      tags = tags.strip.split(',')
        tags.each do |tag|
          tag.strip!
          story.tags << Tag.find_or_create_by!(name: tag)
        end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.friendly.find(params[:id])
    end

    def get_chapters
      @chapters = @story.chapters
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:title, :description, :user_id, :status, :tags)
    end
end
