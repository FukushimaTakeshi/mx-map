class FavoriteCourse < ApplicationRecord
  belongs_to :user
  belongs_to :motocross_course
end
