class ProductsController < ApplicationController
  def import
    Products::ProductsImporter.import
    render json: { message: "Products imported successfully!" }
  end

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

  def search
    results = Product.search_by_name(search_params).records.to_a
    
    render json: results.map { |product|
      {
        id: product.id,
        name: product.name
      }
    }
  end

  def search_params
    params.require(:query)
  end
end
