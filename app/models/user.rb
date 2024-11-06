class User < ApplicationRecord
  has_many :sales_reps
  validates :email, presence: true, uniqueness: true
end
