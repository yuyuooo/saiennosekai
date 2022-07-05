class MonthCrop < ApplicationRecord

  validates :month, presence: true
  validates :crop_name, presence: true
  validates :harvest_time, presence: true
  validates :introduction, presence: true
  validates :method, presence: true

  scope :published, -> {where(is_published_flag: true)}
  scope :unpublished, -> {where(is_published_flag: false)}

  def is_published_flag_color
    is_published_flag ? "font-weight-bold text-success":"font-weight-bold text-muted"
  end

  has_one_attached :crop_image

  def get_crop_image(width, height)
    unless crop_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_crop.jpeg')
      crop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    crop_image.variant(resize_to_limit: [width, height]).processed
  end

end
