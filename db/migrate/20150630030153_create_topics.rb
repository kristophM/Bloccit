class CreateTopics < ActiveRecord::Migration
  def change
    drop_table :topics 
    create_table :topics do |t|
      t.string :name
      t.boolean :public, default: true
      t.text :description

      t.timestamps null: false
    end
  end
end
