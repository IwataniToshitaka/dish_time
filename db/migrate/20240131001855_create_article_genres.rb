class CreateArticleGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :article_genres do |t|
      t.integer :airticle_id
      t.integer :genre_id
      t.timestamps
    end
  end
end
