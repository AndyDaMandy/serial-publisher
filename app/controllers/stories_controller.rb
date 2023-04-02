class StoriesController < ApplicationController
  before_action :set_story, only: %i[ show edit update destroy ]
  before_action :get_chapters, only: %i[ show ]

  # GET /stories or /stories.json
  def index
    if params[:self]
      @stories = current_user.stories
    else
    @stories = Story.all.order("created_at DESC")
    end
  end

  # GET /stories/1 or /stories/1.json
  def show
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
    @story.user = current_user
    create_or_delete_story_tags(@story, params[:story][:tags])

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
    create_or_delete_story_tags(@story, params[:story][:tags])
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

    def create_or_delete_story_tags(story, tags)
      story.taggables.destroy_all
      tags = tags.strip.split(',')
        tags.each do |tag|
          story.tags << Tag.friendly.find_or_create_by(name: tag)
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
      params.require(:story).permit(:title, :description, :user_id, :tags)
    end
end
