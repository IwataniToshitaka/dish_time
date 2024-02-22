class HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :index]

  def top
    @articles = Article.all
  end

  def search
    @model = params['search']['model']
    @content = params['search']['content']
    @method = params['search']['method']
    @result = search_for(@model, @content, @method)
  end

  def index
  end

  private

  def search_for(model, content, method)
    if model == 'user'
      if method == 'forward'
        User.where(
          'name LIKE ?',
          "#{content}%"
        )
      elsif method == 'backward'
        User.where(
          'name LIKE ?',
          "%#{content}"
        )
      elsif method == 'perfect'
        User.where(
          'name = ?',
          content
        )
      else # partial
        User.where(
          'name LIKE ?',
          "%#{content}%"
        )
      end
    elsif model == 'article'
      if method == 'forward'
        Article.where('title LIKE ?', "#{content}%").includes(:genre)
      elsif method == 'backward'
        Article.where('title LIKE ?', "%#{content}").includes(:genre)
      elsif method == 'perfect'
        Article.where(title: content).includes(:genre)
      else # partial
        Article.where('title LIKE ?', "%#{content}%").includes(:genre)
      end
    else
      [] # 空配列を返す
    end
  end
end