class Article < ApplicationRecord

  has_one_attached :image
  #画像投稿
  belongs_to :user
  #1:Nのuserとの関連付け

  #belongs_to :genre
  #ジャンルとの可憐付け　必ずジャンル選択がマストになる

  has_many :likes, dependent: :destroy
  #1投稿につきいいねは複数つく。

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  #バリデーションS
  #タイトル、本文、画像が空欄の場合データ保存されない

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
