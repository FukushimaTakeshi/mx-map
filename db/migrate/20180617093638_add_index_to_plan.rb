class AddIndexToPlan < ActiveRecord::Migration[5.2]
  def change
    add_index :plans, [:date, :uuid, :off_road_circuit_id], name: 'unique_date_uuid_circuit', unique: true
  end
end
