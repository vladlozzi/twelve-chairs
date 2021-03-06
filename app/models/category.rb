class Category < ApplicationRecord
  validates :category, presence: true, uniqueness: true
  has_many :subcategories, dependent: :destroy
end