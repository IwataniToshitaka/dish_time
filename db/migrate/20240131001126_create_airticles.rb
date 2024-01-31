class CreateAirticles < ActiveRecord::Migration[6.1]
  def change
    create_table :airticles do |t|
      t.integer :user_id
      t.text :airticle

      t.timestamps
    end
  end
end
