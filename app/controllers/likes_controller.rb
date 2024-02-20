class LikesController < ApplicationController

  def create
    @like = current_user.likes.create(article_id: params[:article_id])
    #currentUserに基づいたいいねを作成.投稿IDにパラムスIDを格納している
    redirect_back(fallback_location: root_path)
    #いいねしたら前の画面に戻る
    #indexとshowどちらも前の画面に戻る
  end


  def destroy
    @article = Article.find(params[:article_id])
    @like = current_user.likes.find_by(article_id: @article.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    @articles = Article.all
    @user = current_user
  end

end
