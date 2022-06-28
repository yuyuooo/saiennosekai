class Item < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :item_name, presence: true
  validates :item_count, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 9_999_999 },format: { with: /\A[0-9]+\z/ }
  validates :sales_method, presence: true
  validates :sales_area, presence: true
  validates :introduction, length: { minimum: 1, maximum: 300 }
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 9_999_999 },format: { with: /\A[0-9]+\z/ }


  has_one_attached :item_image

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_crop.jpeg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end

  def is_active_color
    is_active ? "font-weight-bold text-success":"font-weight-bold text-muted"
  end

  # def have_is_active?(is_active)
  #   is_actives.exists?(is_active: "販売中")
  # end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def create_notification_like!(current_user)
  like_exist = Notification.where("visitor_id = ? and visited_id = ? and item_id = ? and action = ? ", current_user.id, user.id, id, 'like') # いいねしているか検索
    if like_exist.blank? # 気になるしていない場合に通知を作成
      notification = current_user.active_notifications.new(
      item_id: id,
      visited_id: user_id, # 通知相手に相手のidを指定
      action: 'like', # helperにて使用
      checked: false # defaultでfalse「未確認」を設定
      )
      # 自分の投稿に対する気になるは、通知済み
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end

