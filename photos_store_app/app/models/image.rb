class Image < ApplicationRecord
  self.primary_key = "id"
  
  belongs_to :imageable, polymorphic: true
end
