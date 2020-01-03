class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
