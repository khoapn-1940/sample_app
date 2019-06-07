class SessionsController < ApplicationController
  def new; end

  def authen_success user
    log_in user
    params[:session][:remember_me] == Settings.m ? remember(user) : forget(user)
    redirect_back_or user
  end

  def authen_fail
    flash.now[:danger] = t "chap7.invalidlogin"
    render :new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      authen_success user
    else
      authen_fail
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
