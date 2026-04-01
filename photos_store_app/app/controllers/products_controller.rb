class ProductsController < ApplicationController
  def import
    Products::ProductsImporter.import
    render json: { message: "Products imported successfully!" }
  end

  def index
    @products = Product.all

    respond_to do |format|
      # renders the Vue app via index.html.erb
      format.html
      format.json { parse_products(@products) }
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

  def filter
     name = params[:name]

     @products = if name
       Product.search_by_name(name).records
     else
       Product.all
     end 
     
     parse_products(@products)
  end

  def search_params
    params.require(:query)
  end

  def filter_params
    # TODO: Add price/category filtering
    params.permit(:name, :category)
  end
  
  private

  def parse_products(products)
   render json: products.map { |product|
      {
        id: product.id,
        name: product.name,
        image: product.variants.first&.images.first&.url
      }
    }
  end
end
