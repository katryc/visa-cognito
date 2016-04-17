class AddWaitTimeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :wait_time, :timestamp
  end
end
