class RemoveWaitTimeFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :wait_time, :timestamp
  end
end
