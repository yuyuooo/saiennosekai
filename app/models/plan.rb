class Plan < ApplicationRecord

  belongs_to :user

  validates :crop_title, length: { minimum: 1, maximum: 20 }
  validates :action, length: { minimum: 1, maximum: 40 }

end
