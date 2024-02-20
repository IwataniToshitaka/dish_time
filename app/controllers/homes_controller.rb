class HomesController < ApplicationController
before_action :authenticate_user!
before_action :authenticate_user!, except:[:top, :index]

  def top
    @articles = Article.all
  end

  def index
  end

end