class UsersController < ApplicationController
  #before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:edit, :update]
  def index
    @pagy, @users = pagy(User.all.order("username ASC"))
  end

  def show
    @user = params[:id] ? User.friendly.find(params[:id]) : current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
        respond_to do |format|
          if @user.update(user_params)
            format.html { redirect_to user_url(@user), notice: "PRofile was successfully updated." }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:favorite_quote, :about)
    end
end
