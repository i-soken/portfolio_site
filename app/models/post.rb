class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id,presence: true
  validates :content,presence: true, length: { maximum: 140 }
  validates :picture,presence: true
  validate :picture_size
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user



# アップロードされた画像のサイズをバリデーションする
def picture_size
  if picture.size > 5.megabytes
    errors.add(:picture, "should be less than 5MB")
  end
end

def like(user)
  likes.create(user_id: user.id)
end

def unlike(user)
  likes.find_by(user_id: user.id).destroy
end

def like?(user)
  like_users.include?(user)
end

end