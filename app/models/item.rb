class Item < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

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

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end

