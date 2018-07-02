class License < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
