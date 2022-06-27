class Public::HomesController < ApplicationController
  layout 'public/application'

  def top
   @posts = Post.limit(3).order(id: :DESC)
  end

  def about
  end

end
