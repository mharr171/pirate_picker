class CreateButtons < ActiveRecord::Migration[5.1]
  def change
    create_table :buttons do |t|
      t.boolean :bomb
      t.boolean :clicked
      t.references :room, foreign_key: true


      t.timestamps
    end
  end
end
