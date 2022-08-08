class Post < ApplicationRecord
  belongs_to :user
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image, append: true
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def save_tag(post_tags,image_tags)
    # 2. image_tags から Tag.find_or_create_by するときに AI でた具づけされたとフラグを立てる
    new_tags = image_tags.map do |new_tag|
      Tag.create_with(from_ai: true).find_or_create_by(name: new_tag)
    end
    # 1. 現在のタグの一覧から AI でタグづけされたものを除外する
    manualed_tags = post_tags.map do |post_tag|
      tag = Tag.find_or_create_by(name: post_tag)
      tag unless tag.from_ai
    end.compact
    # 3. self.tag = 1 で残ったタグ + 2 のタグ
    self.tags = (manualed_tags + new_tags).uniq { |tag| tag.name }
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("hotel_name LIKE?","#{word}")
    elsif search == "partial_match"
      @post = Post.where("hotel_name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  validates :hotel_name, presence: true
  validates :text, presence: true

 def get_like(user_id)
   Like.find_by(post_id: self.id, user_id: user_id)
 end

end
