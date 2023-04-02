class ChaptersController < ApplicationController
  before_action :get_story
  before_action :set_chapter, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]

  # GET /chapters or /chapters.json
  def index
    @chapters = @story.chapters.order("chapter_number DESC")
  end

  # GET /chapters/1 or /chapters/1.json
  def show
  end

  # GET /chapters/new
  def new
    @chapter = @story.chapters.build
    #@chapter = Chapter.new
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters or /chapters.json
  def create
    @chapter = @story.chapters.create(chapter_params)
    @chapter.user = current_user

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to story_chapter_path(@story, @chapter), notice: "Chapter was successfully created." }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1 or /chapters/1.json
  def update
    @chapter.user = current_user
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to story_chapter_path(@story, @chapter), notice: "Chapter was successfully updated." }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1 or /chapters/1.json
  def destroy
    @chapter.destroy

    respond_to do |format|
      format.html { redirect_to story_url(@story), notice: "Chapter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_story
      @story = Story.friendly.find(params[:story_id])
    end

    def set_chapter
      @chapter = @story.chapters.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chapter_params
      params.require(:chapter).permit(:title, :chapter_number, :description, :content, :status, :story_id, :user_id)
    end
end
