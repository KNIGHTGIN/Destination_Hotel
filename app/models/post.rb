class Post < ApplicationRecord
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
