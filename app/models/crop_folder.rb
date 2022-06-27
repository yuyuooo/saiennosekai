class CropFolder < ApplicationRecord

  belongs_to :user
  has_many :diaries, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :crop_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :crop_name, length: { minimum: 1, maximum: 20 }
  validates :place, presence: true
  validates :new_crop_date, presence: true
  validates :memo, length: { maximum: 150 }

  has_one_attached :crop_image

  def get_crop_image(width, height)
    unless crop_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_crop.jpeg')
      crop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    crop_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def create_notification_comment!(current_user, book_comment_id)
    comment_users = BookComment.select(:user_id).where(book_id: id).where.not(user_id: current_user.id).distinct
    comment_users.each do |comment_user|
      save_notification_comment!(current_user, book_comment_id, comment_user['user_id']) if comment_users.blank?
    end
      save_notification_comment!(current_user, book_comment_id, user_id) if comment_users.blank?
  end
  
  def save_notification_comment!(current_user, book_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      book_id: id,
      book_comment_id: book_comment_id,
      visited_id: visited_id,
      action: 'comment',
      checked: false
    )
    notification.save! if notification.valid?
  end

end

