class CreateTurnlists < ActiveRecord::Migration[5.1]
  def change
    create_table :turnlists do |t|
      t.references :room, foreign_key: true
      t.integer :first
      t.integer :second
      t.integer :third
      t.integer :fourth

      t.timestamps
    end
  end
end
