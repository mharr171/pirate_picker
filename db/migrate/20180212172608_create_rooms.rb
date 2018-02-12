class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.boolean :game_start
      t.boolean :game_end
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :rooms, :name
  end
end
