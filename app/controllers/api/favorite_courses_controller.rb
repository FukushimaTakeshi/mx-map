class Api::FavoriteCoursesController < ApplicationController
  def index
    favorite_courses = current_user.favorite_courses
    
    render json: {
      favorite_courses: favorite_courses
    }
  end

  def create
  end

  def destroy
  end
end
