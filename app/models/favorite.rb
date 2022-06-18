class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :crop_folder

end
