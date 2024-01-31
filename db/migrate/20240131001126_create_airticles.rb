class CreateAirticles < ActiveRecord::Migration[6.1]
  def change
    create_table :airticles do |t|
      t.integer :id
      t.integer :user_id
      text :airticle

      t.timestamps
    end
  end
end
