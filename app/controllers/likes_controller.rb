class LikesController < ApplicationController

  def create
    @like = current_user.likes.create(airticle_id: params[:airticle_id])
    #currentUserに基づいたいいねを作成.投稿IDにパラムスIDを格納している
    redirect_back(fallback_location: root_path)
    #いいねしたら前の画面に戻る
    #indexとshowどちらも前の画面に戻る
  end


  def destroy
    @airticle = Airticle.find(params[:airticle_id])
    @like = current_user.likes.find_by(airticle_id: @airticle.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    @airticles = Airticle.all
    @user = current_user
  end

end
