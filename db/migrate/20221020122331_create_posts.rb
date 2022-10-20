class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :text, null: false
      t.timestamps
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
    end
  end
end
