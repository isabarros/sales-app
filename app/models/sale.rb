class Sale < ApplicationRecord
  belongs_to :sales_rep
  has_many :items, dependent: :destroy
end
