class AirticlesController < ApplicationController
before_action :authenticate_user!

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
        redirect_to airticle_path(@airticle.id), notice:'airticle created successfully.'
        #(.id)をつけることで投稿した内容を保持する
      else
        render :new #このアクション内に定義要
      end
        #投稿したユーザを識別するID
        #投稿のユーザIDが現在ログインしているユーザID
      #つまり、この投稿のユーザIDに現在ログインしているユーザIDを格納する処理
  end

  def edit
    @airticle = Airticle.find(params[:id])
    if @airticle.user != current_user
      redirect_to airticles_path, alert: '不正なアクセスです。'
    end
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
    airticle = Airticle.find(params[:id])
    airticle.destroy
    redirect_to airticles_path
    #viewに渡す必要がないのでローカル変数表記
  end

  def update
    @airticle = Airticle.find(params[:id])
    if @airticle.update(airticle_params)
      redirect_to airticles_path(@airticle), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  private

  def airticle_params
    params.require(:airticle).permit(:title, :body, :image)
  end

end
