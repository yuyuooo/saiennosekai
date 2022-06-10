class Plan < ApplicationRecord

  belongs_to :user
  belongs_to :crop_folder

  #validates :crop_title, presence: true
  validates :action, length: { minimum: 1, maximum: 40 }

end
