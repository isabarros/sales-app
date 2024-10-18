class User < ApplicationRecord
  has_one :sales_rep, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
