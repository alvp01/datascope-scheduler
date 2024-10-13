class Api::V1::UsersController < ApplicationController
  def show
    begin
      @user = User.includes(:events).find(params[:id])
      render json: { user: UserSerializer.new(@user) }
    rescue StandardError => e
      render json: { error: e }, status: :bad_request
    end
  end

  def index
    @users = User.all
    render json: { users: UserSerializer.new(@users) }
  end

  def create
    begin
      @user = User.create!(user_params)
      render json: { user: UserSerializer.new(@user) }
    rescue StandardError => e
      render json: { error: e }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
