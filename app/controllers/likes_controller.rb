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
  # 自分がいいねした記事のarticle_idを取得
  liked_article_ids = current_user.likes.pluck(:article_id)

  # 取得したarticle_idでArticleテーブルから該当する投稿データを取得
  @articles = Article.where(id: liked_article_ids)
  @user = current_user
end

end
