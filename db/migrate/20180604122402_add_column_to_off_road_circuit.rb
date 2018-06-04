class AddColumnToOffRoadCircuit < ActiveRecord::Migration[5.2]
  def change
    add_column :off_road_circuits, :place_id, :string
  end
end
