class AddDeviceToken < ActiveRecord::Migration
  def change
    add_column(:children, :device_token, :string, null: false)
  end
end
