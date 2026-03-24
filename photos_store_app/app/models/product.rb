class Product < ApplicationRecord
  self.primary_key = "id"
  
  has_many :variants
  has_many :images, as: :imageable
  has_many :additional_informations
end
