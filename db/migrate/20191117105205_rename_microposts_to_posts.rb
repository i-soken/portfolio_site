class RenameMicropostsToPosts < ActiveRecord::Migration[5.1]
  def change
    rename_table :microposts , :posts
  end
end
