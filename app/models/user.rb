# == Schema Information
# Table name: users
#
#  id                        :bigint(8)        not null, primary key
#  email                     :string           default(''), not null
#  encrypted_password        :string           default(''), not null
#  reset_password_token      :string
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0), not null
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :inet
#  last_sign_in_ip           :inet
#  confirmation_token        :string
#  confirmed_at              :datetime
#  confirmation_sent_at      :datetime
#  unconfirmed_email         :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  provider                  :string
#  uid                       :string
#  username                  :string
#  admin                     :boolean          default(FALSE), not null
#  avatar                    :string

class User < ApplicationRecord
  has_many :plan, dependent: :delete_all
  has_many :favorite_courses
  has_many :off_road_circuits, through: :favorite_courses
  has_one :mx_profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :mx_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:twitter, :facebook, :google_oauth2]

  mount_uploader :avatar, AvatarUploader

  def self.find_for_oauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.email    = auth.info.email
      case auth.provider
      when 'twitter'
        user.username = auth.info.nickname
        user.remote_avatar_url = auth.info.image
      when 'facebook', 'google_oauth2'
        user.username = auth.info.name
        user.remote_avatar_url = auth.info.image
      end
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
        user.remote_avatar_url = session['devise.user_attributes']['avatar']
      end
    else
      super
    end
  end
end
