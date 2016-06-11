class CreateWorries < ActiveRecord::Migration
  def change
    create_table :worries do |t|
      t.boolean :notificationed, null: false, default: false
      t.references :parent, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
