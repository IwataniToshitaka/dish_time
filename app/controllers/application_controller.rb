class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except:[:top, :about, :genres]

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

 # def require_login
 #   if session[:user_id].nil?
 #     redirect_to user_session_path
 #   end
 # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    #サインアップした時のemailをパラメータとして登録する
  end
end
