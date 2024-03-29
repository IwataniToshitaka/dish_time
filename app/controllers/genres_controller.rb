class GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_genre, only: [:show, :edit, :update, :destroy]

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
       @genre.update_columns(is_active: false)
       #update_columnsにより変更した対象のみ更新する
       #update_allはstring型に使用できずエラーが出る
      end
     redirect_to genres_path, notice: "---ジャンルを編集しました---"
   else
     render :edit
   end
  end

def destroy
  @genre = Genre.find(params[:id])
  genre_name = @genre.name # 削除したジャンルの名称を変数に代入
  @genre.destroy
  redirect_to genres_path, notice: "---ジャンルから「#{genre_name}」を削除しました！---"
  # フラッシュメッセージにジャンルの名称を表示
end

    private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

  def ensure_genre
    @genre = Genre.find(params[:id])
  end
end