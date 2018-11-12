require 'rails_helper'

RSpec.describe 'FavoriteCoursesApis', type: :request do
  before do
    @user = FactoryBot.build(:user)
    @user.skip_confirmation!
    @user.save!
    sign_in @user

    off_road_circuit
    FactoryBot.create(:photo, off_road_circuit_id: off_road_circuit.id)
    favorite_course
  end

  let(:off_road_circuit) { FactoryBot.create(:off_road_circuit, prefecture_id: 1, region_id: 1) }
  let(:favorite_course) { FactoryBot.create(:favorite_course, user_id: @user.id, off_road_circuit_id: off_road_circuit.id) }

  describe 'GET /api/:user_id/favorite_courses' do
    before { get api_user_favorite_courses_path(@user) }
    it 'httpステータス200が返ること' do
      expect(response).to have_http_status(:success)
    end

    it 'レスポンスが想定通り' do
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
      expect(json['favorite_courses'].length).to eq 1
      expect(json['favorite_courses'][0]['id']).to eq favorite_course.id
      expect(json['favorite_courses'][0]['off_road_circuit_id']).to eq off_road_circuit.id
      expect(json['favorite_courses'][0]['name']).to eq 'テストサーキット'
      expect(json['favorite_courses'][0]['photo_url']).to eq 'https://sample.com'
    end
  end
  
  describe 'POST /api/:user_id/favorite_courses' do
    context 'パラメータが正しい場合' do
      let(:params) { { favorite_course: { off_road_circuit_id: off_road_circuit.id ,user_id: @user.id} } }
      it 'httpステータス201が返ること' do
        post api_user_favorite_courses_path(@user), params: params
        expect(response).to have_http_status(:created)
      end
      it 'FavoriteCourseレコードが1増えること' do
        expect{ post api_user_favorite_courses_path(@user), params: params }.to change(FavoriteCourse, :count).by(1)
      end
    end
    
    context 'パラメータが正しくない場合' do
      let(:params) { { favorite_course: { off_road_circuit_id: '' ,user_id: @user.id} } }
      it 'httpステータス422が返ること' do
        post api_user_favorite_courses_path(@user), params: params
        expect(response).to have_http_status(422)
      end
      it 'FavoriteCourseレコードが1増えないこと' do
        expect{ post api_user_favorite_courses_path(@user), params: params }.not_to change(FavoriteCourse, :count)
      end
    end
  end
  
  describe 'DELETE /api/:user_id/favorite_courses/:id' do
    let(:params) { { id: favorite_course.id } }
    it 'httpステータス200が返ること' do
      delete api_user_favorite_course_path(@user, favorite_course)
      expect(response).to have_http_status(:success)
    end
    it 'FavoriteCourseレコードが1削除されること' do
      expect{ delete api_user_favorite_course_path(@user, favorite_course) }.to change(FavoriteCourse, :count).by(-1)
    end
  end
end
