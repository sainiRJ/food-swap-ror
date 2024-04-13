class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_format_of :email, with: Devise::email_regexp
  validates :phone, length: { in: 10..15 }, numericality: { only_integer: true }, if: :phone_changed?



end
