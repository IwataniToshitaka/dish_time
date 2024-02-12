class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :airticles, dependent: :destroy
   #userと投稿の1:N userが消えたら投稿もすべて消える
  has_many :likes, dependent: :destroy
   #1投稿につきいいねは複数つく。

  def already_liked?(airticle)
    self.likes.exists?(airticle_id: airticle.id)
    #いいねの中で投稿IDが今言い値仕様としている投稿IDが存在しているか確認している
    #いいねが重複していないか確認
  end

end
