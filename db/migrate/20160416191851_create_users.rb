class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :phone

      t.timestamps null: false
    end
  end
end
