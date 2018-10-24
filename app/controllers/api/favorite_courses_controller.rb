class Api::FavoriteCoursesController < ApplicationController
  def index
    favorite_courses = current_user.favorite_courses
    render json: {
      favorite_courses: favorite_courses.map do |favorite_course|
        { 
          id: favorite_course.id,
          off_road_circuit_id: favorite_course.off_road_circuit.id,
          name: favorite_course.off_road_circuit.name,
          photo_url: favorite_course.off_road_circuit.photo[0]&.url
        }
      end
    }
  end

  def create
  end

  def destroy
  end
end
