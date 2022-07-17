class Public::HomesController < ApplicationController
  layout 'public/application'

  def top
   @posts = Post.limit(3).order(id: :DESC)
   @ranking_comments = Post.joins(:comments).group('comments.post_id').order('count(comments.id) desc')
   @ranking_likes = Post.joins(:likes).group('likes.post_id').order('count(likes.id) desc')
  end

  def about
  end

end
