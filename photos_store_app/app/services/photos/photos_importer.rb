# the module/s specifies the file path
module Photos
    class PhotosImporter
        # Ruby Gem that allows us to make HTTP requests
        include HTTParty

        API_BASE_URL = ENV['API_BASE_URL']
        API_TOKEN = ENV['API_TOKEN']
        URL = "#{API_BASE_URL}/collections/all/products?storefront_token=#{API_TOKEN}"


        # self means the method can be called without creating an instance of the class
        def self.import
            # trigger the external API and hydrate the local database
            response = HTTParty.get(URL)
            # Rails.logger.info "Response: #{response["results"]}"
            response["results"].each do |config|
                id, name, price, image_url = config.values_at( "id", "name", "price", "image_url")
                photo = Photo.find_or_initialize_by(external_id: id)
                photo.assign_attributes(
                    name:,
                    price:,
                    image_url:,
                )
                photo.save!
            end
        end
    end
end