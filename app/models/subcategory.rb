class Subcategory < ApplicationRecord
  validates :subcategory, presence: true, uniqueness: true
  belongs_to :category
end