# frozen_string_literal: true

# Controller for chapters, belongs to users and to stories
class ChaptersController < ApplicationController
  before_action :set_story, only: %i[index new create show edit update destroy]
  before_action :set_chapter, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  # GET /chapters or /chapters.json
  def index
    @chapters = if user_signed_in?
                  if @story.user == current_user
                    @story.chapters.order('chapter_number DESC')
                  else
                    @story.chapters.where(status: 'published').order('created_at DESC')
                  end
                else
                  @story.chapters.where(status: 'published').order('created_at DESC')
                end
  end

  def all_chapters
    @chapters = Chapter.where(status: 'published').order('created_at DESC')
  end

  # GET /chapters/1 or /chapters/1.json
  def show
    if user_signed_in?
      if @chapter.status != 'published' && @chapter.user != current_user
        redirect_to story_path, alert: 'You do not have access to this page'
      end
    elsif @chapter.status != 'published'
      redirect_to story_path, alert: 'You do not have access to this page'
    end
  end

  # GET /chapters/new
  def new
    @chapter = @story.chapters.build
  end

  # GET /chapters/1/edit
  def edit; end

  # POST /chapters or /chapters.json
  def create
    @chapter = @story.chapters.create(chapter_params)
    @chapter.user = current_user

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to story_chapter_path(@story, @chapter), notice: 'Chapter was successfully created.' }
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
        format.html { redirect_to story_chapter_path(@story, @chapter), notice: 'Chapter was successfully updated.' }
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
      format.html { redirect_to story_url(@story), notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = Story.friendly.find(params[:story_id])
  end

  def set_chapter
    @chapter = @story.chapters.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def chapter_params
    params.require(:chapter).permit(:title, :chapter_number, :content, :status, :story_id, :user_id)
  end
end
