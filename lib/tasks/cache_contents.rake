namespace :chache_contents do
  desc 'google place apiを30日キャッシュする'
  task place_details_search: :environment do
    OffRoadCircuit.all.find_each do |course|
      cache_value = JSON.dump(PlaceSearch.new(query: course.place_id).details)
      Rails.cache.write(course.place_id, cache_value, expired_in: 10.days)
    end
  end
end
