class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.references :parent, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
