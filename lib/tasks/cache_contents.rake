namespace :chache_contents do
  desc 'google place apiを30日キャッシュする'
  task place_details_search: :environment do
    OffRoadCircuit.all.find_each do |course|
      cache_value = JSON.dump(PlaceSearch.new(query: course.place_id).details)
      Rails.cache.write(course.place_id, cache_value, expired_in: 10.days)
    end
  end

  desc 'google place apiから画像IDを保存する'
  task place_image: :environment do
    OffRoadCircuit.all.find_each do |course|
      Photo.where(off_road_circuit_id: course.id).delete_all

      details = JSON.parse(Rails.cache.read(course.place_id))
      details['result']['photos']&.each do |photo|
        break if photo.nil?
        location = PlaceSearch.new(query: photo['photo_reference']).photo
        Photo.create(url: location, off_road_circuit_id: course.id)
      end
    end
  end
end
