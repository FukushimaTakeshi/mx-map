# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Region.find_or_create_by(id: 1, name: '北海道')
Region.find_or_create_by(id: 2, name: '東北')
Region.find_or_create_by(id: 3, name: '関東')
Region.find_or_create_by(id: 4, name: '中部')
Region.find_or_create_by(id: 5, name: '近畿')
Region.find_or_create_by(id: 6, name: '中国')
Region.find_or_create_by(id: 7, name: '四国')
Region.find_or_create_by(id: 8, name: '九州')

Prefecture.find_or_create_by(id: 1, region_id: 1, name: '北海道')
Prefecture.find_or_create_by(id: 2, region_id: 2, name: '青森県')
Prefecture.find_or_create_by(id: 3, region_id: 2, name: '岩手県')
Prefecture.find_or_create_by(id: 4, region_id: 2, name: '宮城県')
Prefecture.find_or_create_by(id: 5, region_id: 2, name: '秋田県')
Prefecture.find_or_create_by(id: 6, region_id: 2, name: '山形県')
Prefecture.find_or_create_by(id: 7, region_id: 2, name: '福島県')
Prefecture.find_or_create_by(id: 8, region_id: 3, name: '茨城県')
Prefecture.find_or_create_by(id: 9, region_id: 3, name: '栃木県')
Prefecture.find_or_create_by(id: 10, region_id: 3, name: '群馬県')
Prefecture.find_or_create_by(id: 11, region_id: 3, name: '埼玉県')
Prefecture.find_or_create_by(id: 12, region_id: 3, name: '千葉県')
Prefecture.find_or_create_by(id: 13, region_id: 3, name: '東京都')
Prefecture.find_or_create_by(id: 14, region_id: 3, name: '神奈川県')
Prefecture.find_or_create_by(id: 15, region_id: 4, name: '新潟県')
Prefecture.find_or_create_by(id: 16, region_id: 4, name: '富山県')
Prefecture.find_or_create_by(id: 17, region_id: 4, name: '石川県')
Prefecture.find_or_create_by(id: 18, region_id: 4, name: '福井県')
Prefecture.find_or_create_by(id: 19, region_id: 4, name: '山梨県')
Prefecture.find_or_create_by(id: 20, region_id: 4, name: '長野県')
Prefecture.find_or_create_by(id: 21, region_id: 4, name: '岐阜県')
Prefecture.find_or_create_by(id: 22, region_id: 4, name: '静岡県')
Prefecture.find_or_create_by(id: 23, region_id: 4, name: '愛知県')
Prefecture.find_or_create_by(id: 24, region_id: 4, name: '三重県')
Prefecture.find_or_create_by(id: 25, region_id: 5, name: '滋賀県')
Prefecture.find_or_create_by(id: 26, region_id: 5, name: '京都府')
Prefecture.find_or_create_by(id: 27, region_id: 5, name: '大阪府')
Prefecture.find_or_create_by(id: 28, region_id: 5, name: '兵庫県')
Prefecture.find_or_create_by(id: 29, region_id: 5, name: '奈良県')
Prefecture.find_or_create_by(id: 30, region_id: 5, name: '和歌山県')
Prefecture.find_or_create_by(id: 31, region_id: 6, name: '鳥取県')
Prefecture.find_or_create_by(id: 32, region_id: 6, name: '島根県')
Prefecture.find_or_create_by(id: 33, region_id: 6, name: '岡山県')
Prefecture.find_or_create_by(id: 34, region_id: 6, name: '広島県')
Prefecture.find_or_create_by(id: 35, region_id: 6, name: '山口県')
Prefecture.find_or_create_by(id: 36, region_id: 7, name: '徳島県')
Prefecture.find_or_create_by(id: 37, region_id: 7, name: '香川県')
Prefecture.find_or_create_by(id: 38, region_id: 7, name: '愛媛県')
Prefecture.find_or_create_by(id: 39, region_id: 7, name: '高知県')
Prefecture.find_or_create_by(id: 40, region_id: 8, name: '福岡県')
Prefecture.find_or_create_by(id: 41, region_id: 8, name: '佐賀県')
Prefecture.find_or_create_by(id: 42, region_id: 8, name: '長崎県')
Prefecture.find_or_create_by(id: 43, region_id: 8, name: '熊本県')
Prefecture.find_or_create_by(id: 44, region_id: 8, name: '大分県')
Prefecture.find_or_create_by(id: 45, region_id: 8, name: '宮崎県')
Prefecture.find_or_create_by(id: 46, region_id: 8, name: '鹿児島県')
Prefecture.find_or_create_by(id: 47, region_id: 8, name: '沖縄県')

OffRoadCircuit.find_or_create_by(id: 1, name: 'モトクロスビレッジ', address: '東京都中央区', url: 'http://hogehoge.com', place_id: 'ChIJFTp7UfXZGGAR3AR4Xt9TtK8', prefecture_id: 13, region_id: 3)
OffRoadCircuit.find_or_create_by(id: 2, name: 'オフロードビレッジ', address: '東京都千代田区', url: 'http://hogehoge2.com', place_id: 'ChIJY2AuvznFGGARFSvH8kg1AeE', prefecture_id: 13, region_id: 3)
OffRoadCircuit.find_or_create_by(id: 3, name: '成田MXパーク', address: '東京都新宿区', url: 'http://hogehoge3.com', place_id: 'ChIJo0TcyLz1ImARbek38pmlVYg', prefecture_id: 13, region_id: 3)

Plan.find_or_create_by(id: 1, date: Date.today, attendance: 6, off_road_circuit_id: 1)
