class CropFolder < ApplicationRecord

  belongs_to :user
  has_many :diaries, dependent: :destroy
  has_many :plans, dependent: :destroy

  validates :crop_name, length: { minimum: 1, maximum: 20 }
  validates :place, presence: true
  validates :new_crop_date, presence: true
  validates :memo, length: { maximum: 150 }

end
