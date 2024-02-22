class ArticlesController < ApplicationController
before_action :authenticate_user!

  def new
    @article = Article.new
  end


  def create
    #@user = current_user
    #@articles = Article.all
    @article = Article.new(article_params)
      #投稿内容が@airticleに格納
    @article.user_id = current_user.id
      if @article.save
        redirect_to article_path(@article.id), notice:'article created successfully.'
        #(.id)をつけることで投稿した内容を保持する
      else
        render :new #このアクション内に定義要
      end
        #投稿したユーザを識別するID
        #投稿のユーザIDが現在ログインしているユーザID
      #つまり、この投稿のユーザIDに現在ログインしているユーザIDを格納する処理
  end

  def edit
    @article = Article.find(params[:id])
    if @article.user != current_user
      redirect_to articles_path, alert: '不正なアクセスです。'
    end
  end

  def index
    @articles = Article.all
    @user = current_user
  end


  def show
    @article = Article.find(params[:id])
    @user = @article.user
    @articles = @user.articles
  end


  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path
    #viewに渡す必要がないのでローカル変数表記
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path(@article), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :image, :genre_id)
  end

end
