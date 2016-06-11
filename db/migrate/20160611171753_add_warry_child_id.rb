class AddWarryChildId < ActiveRecord::Migration
  def change
    add_reference :worries, :child, index: true, null: false
  end
end
