class MxProfile < ApplicationRecord
  belongs_to :mx_history, optional: true
  belongs_to :license, optional: true
  belongs_to :user, inverse_of: :mx_profile
end
