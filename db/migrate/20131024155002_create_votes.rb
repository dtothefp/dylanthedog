class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false
      t.belongs_to :post, null: false
    end

    reversible do |dir|
      dir.up do 
        execute <<-SQL
        ALTER TABLE votes
        ADD CONSTRAINT fk_users
        FOREIGN KEY (user_id)
        REFERENCES users(id),
        ADD CONSTRAINT fk_posts
        FOREIGN KEY (post_id)
        REFERENCES posts(id)
        SQL
      end
    end
  end
end
