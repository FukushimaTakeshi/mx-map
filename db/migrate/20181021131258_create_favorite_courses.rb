class CreateFavoriteCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_courses do |t|
      t.references :user, foreign_key: true, index: true
      t.references :off_road_circuit, foreign_key: true, index: true

      t.timestamps
    end
  end
end
