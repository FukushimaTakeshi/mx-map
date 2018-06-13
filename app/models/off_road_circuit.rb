class OffRoadCircuit < ApplicationRecord
  belongs_to :prefecture
  belongs_to :region
  has_many :photo
end
