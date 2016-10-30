class User < ApplicationRecord
  attr_accessor :password_confirmation

  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }
end
