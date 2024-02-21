class GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_genre, only: [:show, :edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(10)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      unless @genre.is_active
        @genre.name.update_all(is_active: false)
      end
      redirect_to genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

  def ensure_genre
    @genre = Genre.find(params[:id])
  end
end