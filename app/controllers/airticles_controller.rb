class AirticlesController < ApplicationController
before_action :is_matching_login_user, only: [:update]

  def new
    @airticle = Airticle.new
  end


  def create
    #@user = current_user
    #@airticles = Airticle.all
    @airticle = Airticle.new(airticle_params)
      #投稿内容が@airticleに格納
    @airticle.user_id = current_user.id
      if @airticle.save
      flash[:notice] = "airticle created successfully."
      redirect_to airticle_path(@airticle.id)
      #(.id)をつけることで投稿した内容を保持する
      else
      flash[:notice] = "Validation error: Please check the input."
      render :index #このアクション内に定義要
      end
      #投稿したユーザを識別するID
      #投稿のユーザIDが現在ログインしているユーザID
      #つまり、この投稿のユーザIDに現在ログインしているユーザIDを格納する処理
  end

  def edit
    @airticle = Airticle.find(params[:id])
  end

  def index
    @airticles = Airticle.all
    @user = current_user
  end


  def show
    @airticle = Airticle.find(params[:id])
    @user = @airticle.user
    @airticles = @user.airticles
  end


  def destroy
    @airticle = Airticle.find(params[:id])
    @airticle.destroy
    redirect_to airticles_path
  end

  def update
    airticle = Airticle.find(params[:id])
    airticle.update(airticle_params)
    redirect_to airticle_path(airticle.id)
  end


  private

  def airticle_params
    params.require(:airticle).permit(:title, :body, :image)
  end

end
