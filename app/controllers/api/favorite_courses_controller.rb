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
    FavoriteCourse.create(favorite_course_params.merge(user_id: params[:user_id]))
    head :ok
  end

  def destroy
  end
  
  private
  
  def favorite_course_params
    params.require(:favorite_course).permit(
      :off_road_circuit_id
    )
  end
end
