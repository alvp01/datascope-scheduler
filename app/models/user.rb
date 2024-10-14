class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true, email: true

  has_many :events
end
