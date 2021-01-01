FactoryBot.define do
  factory :off_road_circuit do
    name { 'テストサーキット' }
    address { '北海道ほげ' }
    url { 'http://sample.com' }
    sequence(:place_id) { |n| "ChIJFTp7UfXZGGAR3AR4Xt9TtK#{n}" }
  end
end
