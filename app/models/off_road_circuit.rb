class OffRoadCircuit < ApplicationRecord
  belongs_to :prefecture
  belongs_to :region
  has_many :photo, dependent: :destroy
  has_many :plan, dependent: :destroy

  validates :name, presence: true
  validates :place_id, presence: true
  validates :prefecture_id, presence: true
  validates :region_id, presence: true
end
