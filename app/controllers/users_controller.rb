class UsersController < ApplicationController
  before_action :logged_in_user, only:[:index,:edit,:update,:following,:followers,:destroy]
  before_action :correct_user,   only: [:edit, :update]
  #before_action :admin_user, only:[:destroy]
  #users/editより退会ボタンを使用するので今の仕様では使用しない。

  def index
    @users = User.paginate(page: params[:page]).search(params[:search])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page]).search(params[:search])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if  !@user.password.nil? && !@user.password.empty? && @user.save
        log_in @user
        flash[:success] = "登録完了しました！"
        redirect_to @user
      else
        flash.now[:danger] = "無効な入力があります。"
        render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Landscapeを退会しました。"
    redirect_to root_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新しました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:realname,:name,:email,:password,
      :password_confirmation,:sex,:introduction,:tel,:web)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
