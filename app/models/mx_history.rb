class MxHistory < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
