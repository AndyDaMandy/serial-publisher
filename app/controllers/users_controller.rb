class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  def index
    @users = User.all
  end

  def show

  end

  def edit
  end

  def update
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:favorite_quote, :about)
    end
end
