# == Schema Information
# Table name: users
#
#  id                        :bigint(8)        not null, primary key
#  date                      :date
#  off_road_circuit_id       :bigint(8)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  uuid                      :string
#  user_id                   :bigint(8)

class Plan < ApplicationRecord
  belongs_to :off_road_circuit
  belongs_to :user, optional: true

  scope :with_user, -> { includes(:user).references(:user) }
  scope :search_circuit_id, lambda { |id|
    where(off_road_circuit_id: id) if id.present?
  }
  scope :search_date, lambda { |date|
    return if date.blank?
    if date.is_a?(String)
      where(date: date)
    elsif date.is_a?(Array)
      where(date: date[0]..date[1])
    end
  }
  scope :search_user_id, lambda { |user_id|
    where(user_id: user_id) if user_id.present?
  }
end
