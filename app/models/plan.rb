class Plan < ApplicationRecord
  belongs_to :off_road_circuit, dependent: :destroy
end
