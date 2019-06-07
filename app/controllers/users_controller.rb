class UsersController < ApplicationController
  before_action :logged_in_user, except: [:create, :new]
  before_action :load_user, except: [:index, :create, :new]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "chap6.success"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "chap10.destroysuccess"
      redirect_to users_path
    else
      flash[:success] = t "chap10.destroyfail"
      redirect_to root_path
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "chap10.success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def logged_in_success
    store_location
    flash[:danger] = t "chap10.danger"
    redirect_to login_url
  end

  def logged_in_user
    logged_in_success unless logged_in?
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by params[:id]
    return if @user
    flash[:warning] = t "chap6.nouser"
    redirect_to root_path
  end
end
