class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_relationship, only: :destroy
  before_action :load_user, only: :create

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
    redirect_to @user
  end

  def destroy
    current_user.unfollow(@followed)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
    redirect_to @followed
  end

  private

  def load_relationship
    @followed = Relationship.find_by_id(params[:id]).followed
    return if @followed
    flash[:warning] = t "chap6.nouser"
    redirect_to root_path
  end

  def load_user
    @user = User.find_by_id(params[:followed_id])
    return if @user
    flash[:warning] = t "chap6.nouser"
    redirect_to root_path
  end
end
