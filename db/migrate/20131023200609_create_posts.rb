class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, index: true
      t.timestamps
    end
    reversible do |dir|
      dir.up do
        execute <<-SQL  
          ALTER TABLE posts
          ADD CONSTRAINT fk_posts_users
          FOREIGN KEY (user_id)
          REFERENCES users(id)
        SQL
      end
    end
  end
end
