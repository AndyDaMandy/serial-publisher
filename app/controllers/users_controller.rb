class UsersController < ApplicationController
  #before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:edit, :update]
  def index
    @users = User.all
  end

  def show
    @user = params[:id] ? User.friendly.find(params[:id]) : current_user
  end

  def edit
  end

  def update
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
