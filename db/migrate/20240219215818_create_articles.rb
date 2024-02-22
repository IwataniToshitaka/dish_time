class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.integer :genre_id
      t.text :title
      t.text :body

      t.timestamps
    end
  end
end