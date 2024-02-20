class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates_uniqueness_of :article_id, scope: :user_id
  #投稿IDとUserIDをバリデーションすることで１投稿に対して１いいねのみ

end
