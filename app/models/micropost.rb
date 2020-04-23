class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,length: { maximum: 140 }
  validates :picture, presence: true
  validate :picture_size

  private

  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, "投稿できる容量は2MBまでです")
    end
  end

  def self.search(search)
    if search
      where(['content LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
