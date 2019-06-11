class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("chap12.info")
      redirect_to root_url
    else
      flash.now[:danger] = t("chap12.danger")
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "cant be empty")
      render "edit"
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t("chap12.success")
      redirect_to @user
    else
      render :edit
    end
  end
end
