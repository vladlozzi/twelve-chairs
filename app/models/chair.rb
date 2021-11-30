class Chair < ApplicationRecord
  validates :chair, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
  belongs_to :subcategory
end