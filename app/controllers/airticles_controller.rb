class AirticlesController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @airticle = Airticle.new
  end


  def create
    @airticle = Airticle.new
      #投稿内容が@airticleに格納
    @airticle.user_id = current_user.id
      #投稿したユーザを識別するID
      #投稿のユーザIDが現在ログインしているユーザID
      #つまり、この投稿のユーザIDに現在ログインしているユーザIDを格納する処理
    @airticle.save
    redirect_to airticles_path
  end


  def index
    @airticles = Airticle.all
  end

def show
  @airticle = Airticle.find(params[:id])
  @user = @airticle.user
  @airticles = @user.airticles
end

end
