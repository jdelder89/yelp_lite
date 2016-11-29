class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps

    end
  end
end
