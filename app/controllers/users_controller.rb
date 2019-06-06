class UsersController < ApplicationController
  def show
    @user = User.find_by_id params[:id]
    return if @user
    render html: (t "chap6.nouser")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "chap6.success"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
