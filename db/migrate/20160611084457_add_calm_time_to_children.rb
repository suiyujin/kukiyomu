class AddCalmTimeToChildren < ActiveRecord::Migration
  def change
    add_column :children, :calm_time, :time
  end
end
