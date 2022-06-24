class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :crop_folders, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :crop_comments, dependent: :destroy
  has_many :items, dependent: :destroy 

  #validates :nickname, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :name, presence: true
  validates :introduction, length: { maximum: 50 }

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end

