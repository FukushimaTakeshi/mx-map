class Inquiry
  include ActiveModel::Model
  attr_accessor :title, :email, :message
  
  validates :title, presence: true, length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :message, presence: true,  length: { maximum: 2000 }
  
  def save
  end
end
