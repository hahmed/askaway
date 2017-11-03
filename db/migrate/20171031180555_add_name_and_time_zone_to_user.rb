class AddNameAndTimeZoneToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :time_zone, :string, null: false, default: 'UTC'
  end
end
