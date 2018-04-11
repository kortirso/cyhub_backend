class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[update destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?
  before_action :find_users, only: %i[index]
  before_action :find_user, only: %i[edit update destroy]

  def index; end

  def edit; end

  def update
    @user.update(user_params)
    redirect_to users_path
  end

  def destroy
    @user.destroy
    redirect_to users_path, status: 303
  end

  private def find_users
    @users = User.order(id: :asc)
  end

  private def find_user
    @user = User.find_by(id: params[:id])
    render_not_found if @user.nil?
  end

  private def user_params
    params.permit(:username, :role)
  end
end
