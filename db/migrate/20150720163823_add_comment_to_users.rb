class AddCommentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :comment_id, :integer
    add_index :users, :comment_id
  end
end
