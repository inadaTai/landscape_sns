class CommentsController < ApplicationController
  include NotificationsHelper
  @@action_name="comment"

  def index
  end

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      @comment.create_notification_by(current_user)
      redirect_to micropost_path(@micropost)
    else
      flash[:danger] = "空欄または140文字を超えると無効な投稿です。"
      redirect_to "/microposts/#{@micropost.id}"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    @comment.delete_notification_by(current_user)
    redirect_to  request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
