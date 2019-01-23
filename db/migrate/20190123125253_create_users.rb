class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :point_id
      t.text :content

      t.timestamps
    end
  end
end
