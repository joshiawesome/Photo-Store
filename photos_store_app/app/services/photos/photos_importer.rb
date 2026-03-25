# the module/s specifies the file path
module Photos
    class PhotosImporter
        # Ruby Gem that allows us to make HTTP requests
        include HTTParty
        # self means the method can be called without creating an instance of the class
        def self.import
            api_base_url = ENV['API_BASE_URL']
            api_token = ENV['API_TOKEN']
            url = "#{api_base_url}/collections/all/products?storefront_token=#{api_token}"

            # trigger the external API and hydrate the local database
            response = HTTParty.get(url)
            data = response.parsed_response["data"]

            data.each do |config|
                # 1. HYDRATE PRODUCTS TABLE

                product = Product.find_or_initialize_by(id: config["id"])

                product.assign_attributes(
                    name: config["name"],
                    slug: config["slug"],
                    description: config["description"],
                    state: config["state"],
                    access: config["access"],
                    created_at: config["created_at"],
                    updated_at: config["updated_at"]
                )

                product.save!

                # 2. HYDRATE THE IMAGES TABLE BASED ON PRODUCTS

                config['images'].each do |image_config|
                    product_image = product.images.find_or_initialize_by(id: image_config["id"])

                    product_image.assign_attributes(
                        url: image_config["url"],
                        transformed: image_config["transformedUrl"],
                        width: image_config["width"],
                        height: image_config["height"]
                    )

                    product_image.save!
                end

                # product_image = product.images.find_or_initialize_by(id: image_config["id"])

                # 3. HYDRATE VARIANTS TABLE
    
                config["variants"].each do |variant_config|
                    # de-structuring can be done as follows:
                    # name, sku = config.values_at("name", "sku")
    
                    variant = product.variants.find_or_initialize_by(id: variant_config["id"])

                    variant.assign_attributes(
                        name: variant_config["name"],
                        sku: variant_config["sku"],
                        # dig is a safe way to access nested hash values
                        price_value: variant_config.dig("unitPrice", "value"),
                        price_currency: variant_config.dig("unitPrice", "currency"),
                        compare_at_price_value: variant_data.dig("compareAtPrice", "value"),
                        compare_at_price_currency: variant_data.dig("compareAtPrice", "currency"),
                        stock_type: variant_data.dig("stock", "type"),
                        weight_value: variant_data.dig("weight", "value"),
                        weight_unit: variant_data.dig("weight", "unit"),
                        length: variant_data.dig("dimensions", "length"),
                        width: variant_data.dig("dimensions", "width"),
                        height: variant_data.dig("dimensions", "height"),
                        dimension_unit: variant_data.dig("dimensions", "unit")
                    )

                    variant.save!

                    # 4. HYDRATE THE VARIANT ATTRIBUTES TABLE

                    variant_attributes = variant_config["attributes"]

                    # find_or_initialize_by can't be use here because 
                    # this is a one to one relationship and variant-attribute is an object not a collection
                    variant_attribute = variant.build_variant_attributes(
                        description: variant_attributes["description"],
                        color_name: variant_attributes.dig("color", "name"),
                        color_swatch: variant_attributes.dig("color", "swatch"),
                        size_name: variant_attributes.dig("size", "name")
                    )
                
                    variant_attribute.save!

                    # 5. HYDRATE THE IMAGES TABLE BASED ON VARIANTS

                    variant_config["images"].each do |image_config|
                        variant_image = variant.images.find_or_initialize_by(id: image_config["id"])

                        variant_image.assign_attributes(
                            url: image_config["url"],
                            transformed: image_config["transformedUrl"],
                            width: image_config["width"],
                            height: image_config["height"]
                        )

                        variant_image.save!
                    end
                    
                
                end

                # 6. HYDRATE THE ADDITIONAL INFORMATIONS TABLE
                
                config["additionalInformation"].each do |info_config|
                  info =  product.additional_informations.find_or_initialize_by(id: info_config["id"])

                  info.assign_attributes(
                    info_type: info_config["type"],
                    title: info_config["title"],
                    body_html: info_config["bodyHtml"]
                  )

                  info.save!
                end
                
            end
        end
    end
end