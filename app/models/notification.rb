class Notification < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }

  belongs_to :crop_folder, optional: true
  belongs_to :crop_comment, optional: true
  belongs_to :item, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
end
