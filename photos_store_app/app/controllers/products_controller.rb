class ProductsController < ApplicationController
  def index
    @products = Product.all

    respond_to do |format|
      format.html # renders the Vue app via index.html.erb

      format.json {
        render json: @products.map { |product|
          {
            id: product.id,
            name: product.name,
            image: product.variants.first&.images.first&.url
          }
        }
      }
    end
  end

  def import
    Products::ProductsImporter.import
    render json: { message: "Products imported successfully!" }
  end
end
