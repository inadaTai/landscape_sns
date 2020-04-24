class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  belongs_to :contributer, class_name:'User', foreign_key: 'user_id'
  validates :user_id, presence: true
  validates :content, presence: true,length: { maximum: 140 }
  validates :picture, presence: true
  validate :picture_size

  def iine(user)
    likes.create(user_id: user.id)
  end

  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  def iine?(user)
    iine_users.include?(user)
  end

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
