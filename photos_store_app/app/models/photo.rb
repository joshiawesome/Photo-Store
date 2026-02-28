class Photo < ApplicationRecord
    # :external_id is a symbol - more specifically it is a hash key
    # presence: true translates to :presence => true which is essentially :key => value
    # so the above code is the same as:
    # validates(:external_id, {
    #   presence: true,
    #   uniqueness: true
    # })
    validates :external_id, presence: true, uniqueness: true
    validates :name, presence: true
end
