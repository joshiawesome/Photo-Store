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

            data = response.parsed_response["results"]

            # Rails.logger.info JSON.pretty_generate(data.as_json)

            data.each do |config|
                # 1. HYDRATE PRODUCTS TABLE

                product = Product.find_or_initialize_by(id: config["id"])

                product.assign_attributes(
                    name: config["name"],
                    slug: config["slug"],
                    description: config["description"],
                    state: config["state"],
                    access: config["access"]
                )

                product.save!

                # 2. HYDRATE THE IMAGES TABLE BASED ON PRODUCTS

                config['images'].each do |image_config|
                    product_image = Image.find_or_initialize_by(id: image_config["id"])
                    # the above snippet can also be written as
                    # product_image  = product.images.find_or_initialize_by(id: image_config["id"])
                    # but this could create a image record with a duplicate id as it only searched the subset of images for that product

                    product_image.assign_attributes(
                        imageable: product,
                        url: image_config["url"],
                        transformed_url: image_config["transformedUrl"],
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
                        compare_at_price_value: variant_config.dig("compareAtPrice", "value"),
                        compare_at_price_currency: variant_config.dig("compareAtPrice", "currency"),
                        stock_type: variant_config.dig("stock", "type"),
                        weight_value: variant_config.dig("weight", "value"),
                        weight_unit: variant_config.dig("weight", "unit"),
                        length: variant_config.dig("dimensions", "length"),
                        width: variant_config.dig("dimensions", "width"),
                        height: variant_config.dig("dimensions", "height"),
                        dimension_unit: variant_config.dig("dimensions", "unit")
                    )

                    variant.save!

                    # 4. HYDRATE THE VARIANT ATTRIBUTES TABLE

                    variant_attributes = variant_config["attributes"]

                    # find_or_initialize_by can't be use here because 
                    # this is a one to one relationship and variant-attribute is an object not a collection
                    # the or condition here is used to prevent the insertion of duplicate records
                    variant_attribute = variant.variant_attribute || variant.build_variant_attribute

                    variant_attribute.assign_attributes(
                        description: variant_attributes["description"],
                        color_name: variant_attributes.dig("color", "name"),
                        color_swatch: variant_attributes.dig("color", "swatch"),
                        size_name: variant_attributes.dig("size", "name")
                    )
                
                    variant_attribute.save!

                    # 5. HYDRATE THE IMAGES TABLE BASED ON VARIANTS

                    variant_config["images"].each do |image_config|
                        variant_image = Image.find_or_initialize_by(id: image_config["id"])

                        variant_image.assign_attributes(
                            imageable: variant,
                            url: image_config["url"],
                            transformed_url: image_config["transformedUrl"],
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