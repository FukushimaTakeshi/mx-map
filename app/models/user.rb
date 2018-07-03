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

class User < ApplicationRecord
  has_many :plan
  has_one :mx_profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :mx_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:twitter]

  def self.find_for_oauth(auth)
    user = find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |user|
      user.email    = User.tmp_email(auth)
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.username = auth['info']['nickname']
    end

    user.skip_confirmation!
    user
  end

  # def self.new_with_session(params, session)
  #   if session['devise.user_attributes']
  #     new(session['devise.user_attributes']) do |user|
  #       user.attributes = params
  #     end
  #   else
  #     super
  #   end
  # end

  private

  def self.tmp_email(auth)
    "#{auth['uid']}-#{auth['provider']}@example.com"
  end
end
