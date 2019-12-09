class RemoveLikesCountToPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :likes_count, :string
  end
end
