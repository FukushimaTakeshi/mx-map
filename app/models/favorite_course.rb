class FavoriteCourse < ApplicationRecord
  belongs_to :user
  belongs_to :off_road_circuit
end
