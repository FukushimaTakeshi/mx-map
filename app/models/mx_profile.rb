class MxProfile < ApplicationRecord
  belongs_to :mx_history
  belongs_to :license
  belongs_to :user, inverse_of: :mx_profile
end
