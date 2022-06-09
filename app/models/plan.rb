class Plan < ApplicationRecord

  validates :crop_title, presence: true, length: { minimum: 1, maximum: 20 }
  validates :action, presence: true, length: { minimum: 1, maximum: 40 }

end
