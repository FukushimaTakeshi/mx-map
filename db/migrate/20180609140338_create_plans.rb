class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.date :date
      t.integer :attendance
      t.references :off_road_circuit, foreign_key: true

      t.timestamps
    end
  end
end
