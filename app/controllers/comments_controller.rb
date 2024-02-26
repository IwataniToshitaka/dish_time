class CommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    comment = current_user.comments.new(comment_params)
      #同義
      #comment = PostComment.new(post_comment_params)
      #comment.user_id = current_user.id
    comment.article_id = article.id
    comment.save
    redirect_to article_path(article)
  end

  def show
    @comment = Comment.new
  end

  def destroy
  @article = Article.find(params[:id]) # 記事を取得
  @comment = Comment.find(params[:comment_id])
  @comment.destroy
  redirect_to article_path(@article) # 記事の詳細ページにリダイレクト
  end


    private

  def comment_params
  params.permit(:comment, :user_id)
  end

end
