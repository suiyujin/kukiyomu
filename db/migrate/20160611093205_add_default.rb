class AddDefault < ActiveRecord::Migration
  def change
    change_column(:children, :calm_time, :time, default: '12:00', null: false)
  end
end
