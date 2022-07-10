class CropFolder < ApplicationRecord

  belongs_to :user
  has_many :diaries, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :crop_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :crop_name, length: { minimum: 1, maximum: 20 }
  validates :new_crop_date, presence: true
  validates :place, presence: true
  validates :memo, length: { maximum: 100 }

  scope :published, -> {where(is_published_flag: true)}
  scope :unpublished, -> {where(is_published_flag: false)}

  scope :active, -> {where(is_active: true)}
  scope :unactive, -> {where(is_active: false)}

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

  def is_active_color
    is_active ? "font-weight-bold text-success":"font-weight-bold text-muted"
  end

  def create_notification_comment!(current_user, crop_comment_id)
    # 自分以外のコメント者を取得
    comment_users = CropComment.select(:user_id).where(crop_folder_id: id).where.not(user_id: current_user.id).distinct
    comment_users.each do |comment_user|
      save_notification_comment!(current_user, crop_comment_id, comment_user['user_id'])
    end
    # comment_usersがいない＝初めてのコメントを取得　cropfolderの投稿者へのみ通知
      save_notification_comment!(current_user, crop_comment_id, user_id) if comment_users.blank?
  end
    # 複数回のコメントも通知
  def save_notification_comment!(current_user, crop_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      crop_folder_id: id,
      crop_comment_id: crop_comment_id,
      visited_id: visited_id,
      action: 'comment',
      checked: false
    )
     # 自分の投稿に対するコメントは、通知済み
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save! if notification.valid?
  end


  def create_notification_favorite!(current_user)
  favorite_exist = Notification.where("visitor_id = ? and visited_id = ? and crop_folder_id = ? and action = ? ", current_user.id, user.id, id, 'favorite') # いいねしているか検索
    if favorite_exist.blank? # いいねしていない場合に通知を作成
      notification = current_user.active_notifications.new(
      crop_folder_id: id,
      visited_id: user_id, # 通知相手に相手のidを指定
      action: 'favorite', # helperにて使用
      checked: false # defaultでfalse「未確認」を設定
      )
      # 自分の投稿に対するいいねは、通知済み
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save! if notification.valid?
    end
  end
end

