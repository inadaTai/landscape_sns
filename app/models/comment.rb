class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :body , presence: true, length: { maximum: 140 }
  validates :user_id , presence: true


  def create_notification_by(current_user)
    @notification=current_user.active_notifications.new(
      comment_id:self.id,
      visited_id:self.micropost.contributer.id,
      micropost_id:self.micropost.id,
      action:"comment"
    )
    @notification.save if @notification.valid?
  end

  def delete_notification_by(current_user)
    @notification=current_user.active_notifications.find_by(
      comment_id:self.id,
      visited_id:self.micropost.contributer.id,
      action:"comment"
    )
    @notification.destroy if !@notification.nil?
  end
end
