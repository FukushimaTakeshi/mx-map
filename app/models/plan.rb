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
end
