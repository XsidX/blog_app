class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:show]
  before_action :set_users, only: [:show]
  def index
    @users = User.all
  end

  def show; end

  def new; end

  def create; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @current_user = current_user
  end

  def set_users
    @users = User.all
  end
end
