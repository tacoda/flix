class CreateCharacterizations < ActiveRecord::Migration[6.0]
  def change
    create_table :characterizations do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
