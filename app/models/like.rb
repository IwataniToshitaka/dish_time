class Like < ApplicationRecord
  belongs_to :user
  belongs_to :airticle

  validates_uniqueness_of :airticle_id, scope: :user_id
  #投稿IDとUserIDをバリデーションすることで１投稿に対して１いいねのみ

end
