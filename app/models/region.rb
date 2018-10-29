class Region < ApplicationRecord
  has_many :prefectures
  
  def self.select_list
    self.all.map do |region|
      {
        id: region.id,
        name: region.name,
        prefectures: region.prefectures.map do |prefecture|
          {
            id: prefecture.id,
            name: prefecture.name
          }
        end
      }
    end
  end
end
