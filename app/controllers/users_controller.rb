class UsersController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @airticles = @user.airticles
    #アソシエーションを持っているモデル同士の記述
    #@other_user = User.find(params[:id])
  end

  def index
  @user = current_user
  @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    #特定の呼び出し
  end

  def update
    @user = User.find(params[:id])
   if @user.update!(user_params)
     flash[:notice] = "You have updated successfully."
     redirect_to user_path
   else
     flash[:notice] = "Validation error: Please check the input."
     render 'edit'
   end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id]) #ユーザID(URL)を持ってくる
    unless user.id == current_user.id #ユーザID(URL)がログインIDと異なれば
      redirect_to user_path(current_user.id) #遷移させず指定のページへリダイレクトする
    end
  end

end

