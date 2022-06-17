class CropFolder < ApplicationRecord

  belongs_to :user
  has_many :diaries, dependent: :destroy
  has_many :plans, dependent: :destroy

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

end

