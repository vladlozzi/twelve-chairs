class Subcategory < ApplicationRecord
  validates :subcategory, presence: true, uniqueness: true
  belongs_to :category
  has_many :chairs, dependent: :destroy
end