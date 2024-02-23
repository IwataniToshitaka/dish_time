class ArticlesController < ApplicationController
before_action :authenticate_user!, except: [:index]

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
    @articles = Article.page(params[:page]).per(5)
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

  def search
    @model = params['search']['model']
    @content = params['search']['content']
    @method = params['search']['method']
    @articles = search_for(@model, @content, @method)  # @articlesに値を設定する
    @result = @articles.first
  end




  private

  def search_for(model, content, method)
    if model == 'user'
      if method == 'forward'
        User.where(
          'name LIKE ?',
          "#{content}%"
        )
      elsif method == 'backward'
        User.where(
          'name LIKE ?',
          "%#{content}"
        )
      elsif method == 'perfect'
        User.where(
          'name = ?',
          content
        )
      else # partial
        User.where(
          'name LIKE ?',
          "%#{content}%"
        )
      end
    elsif model == 'article'
      if method == 'forward'
        Article.where('title LIKE ?', "#{content}%").includes(:genre)
      elsif method == 'backward'
        Article.where('title LIKE ?', "%#{content}").includes(:genre)
      elsif method == 'perfect'
        Article.where(title: content).includes(:genre)
      else # partial
        Article.where('title LIKE ?', "%#{content}%").includes(:genre)
      end
    else
      [] # 空配列を返す
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :image, :genre_id)
  end

end