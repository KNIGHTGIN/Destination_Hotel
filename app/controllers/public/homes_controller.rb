class Public::HomesController < ApplicationController
  layout 'public/application'

  def top
   @posts = Post.limit(3).order(id: :DESC)
   #@all_ranks = Post.find(Like.group(:post_id).order('count(post_id)desc').limit(3).pluck(:post_id))
  end

  def about
  end

end
