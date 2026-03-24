class Variant < ApplicationRecord
  self.primary_key = "id"

  belongs_to :product
  has_many :images, as: :imageable
  has_one :variant_attribute
end
