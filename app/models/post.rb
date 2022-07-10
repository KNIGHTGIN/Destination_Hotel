class Post < ApplicationRecord
  belongs_to :user
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  def save_tag(post_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - post_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = post_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_tag|
      self.tags.delete　(Tag.find_by(name: old_tag))
    end

    # 新しいタグを保存
    new_tags.each do |new_tag|
      add_tag = Tag.find_or_create_by(name: new_tag)
      self.tags << add_tag
   end
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
