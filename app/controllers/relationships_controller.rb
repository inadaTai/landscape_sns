class RelationshipsController < ApplicationController
  before_action :logged_in_user
  #下記のcreate、destroyアクションchrome、safariのjavaをoffを確認
  #(respond_toなしでも動作確認済みため記載なし)
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    redirect_to @user
  end
end
