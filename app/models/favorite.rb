class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :crop_folder
  has_many :notifications, dependent: :destroy
  
end
