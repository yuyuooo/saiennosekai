class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :crop_folder
  
 
  
  validates :diary_date, presence: true
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :body, length: { maximum: 500 }
  
  has_one_attached :crop_image
  
  def get_crop_image(width, height)
    unless crop_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      crop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    crop_image.variant(resize_to_limit: [width, height]).processed
  end
end
