class CreateLikes < ActiveRecord::Migration[6.1]
  def change
      create_table :likes do |t|
      t.integer :id
      t.integer :user_ids
      t.timestamps
    end
  end
end
