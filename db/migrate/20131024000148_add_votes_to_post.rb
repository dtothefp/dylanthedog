class AddVotesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :votes, :integer, default: 0
  end
end
