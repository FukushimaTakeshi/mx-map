class CreateOffRoadCircuits < ActiveRecord::Migration[5.2]
  def change
    create_table :off_road_circuits do |t|
      t.string :name
      t.string :address
      t.string :url
      t.references :prefecture, foreign_key: true
      t.references :region, foreign_key: true

      t.timestamps
    end
  end
end
