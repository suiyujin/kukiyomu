class CreateBursts < ActiveRecord::Migration
  def change
    create_table :bursts do |t|
      t.references :child, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
