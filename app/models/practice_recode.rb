class PracticeRecode < ApplicationRecord
  belongs_to :off_road_circuit

  attribute :duration_hour, :integer
  attribute :duration_minute, :integer

  validates :practice_date, presence: true
  validates :off_road_circuit_id, presence: true
  validates :practice_date, uniqueness: { scope: :user_id }
  validates :duration_hour, numericality: { only_integer: true, less_than: 24, allow_blank: true }
  validates :duration_minute, numericality: { only_integer: true, less_than: 60, allow_blank: true }

  after_validation :set_duration

  private

  def set_duration
    return if self.duration_hour.blank? && self.duration_minute.blank?
    self.duration = (self.duration_hour || 0) * 60 + (self.duration_minute || 0)
  end
end
