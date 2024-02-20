class GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_genre, only: [:show, :edit, :update]

  def index
    @article_genre = ArticleGenre.new
    @article_genres = ArticleGenre.all
  end

  def create
    @article_genre = ArticleGenre.new(article_genre_params)
    if @article_genre.save
      redirect_to genres_path
    else
      @article_genres = ArticleGenre.all
      render :index
    end
  end

  def edit
  end

  def update
    if @article_genre.update(article_genre_params)
      unless @article_genre.is_active
        @article_genre.items.update_all(is_active: false)
      end
      redirect_to genres_path
    else
      render :edit
    end
  end

  private

  def article_genre_params
    params.require(:article_genre).permit(:name)
  end

  def ensure_genre
    @article_genre = ArticleGenre.find(params[:id])
  end
end