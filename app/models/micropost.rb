class Micropost < ApplicationRecord
  belongs_to :user
  scope :newest, ->{order created_at: :desc}
  scope :newfeeds, ->(id){where "user_id = ?", id}
  scope :postfeed, lambda{|id|
    where "user_id IN (SELECT followed_id FROM relationships
     WHERE  follower_id = user_id) OR user_id = ?", id
  }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.contentMaximum}
  validate  :picture_size

  def picture_size
    errors.add(:picture, Settings.lim) if picture.size > Settings.pMax.megabytes
  end
end
