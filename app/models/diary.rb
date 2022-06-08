class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :crop_folder
  
  has_one_attached :crop_image
  
  
end
