class MxProfile < ApplicationRecord
  belongs_to :history
  belongs_to :license
  belongs_to :user, dependent: :destroy
end
