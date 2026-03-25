class PhotosController < ApplicationController
  def index
    @products = Product.all

    render json: @products.map { |product|
      {
        id: product.id,
        name: product.name,
        image: product.images.first&.url
      }
    }
  end

  def import
    Photos::PhotosImporter.import
    render json: { message: "Photos imported successfully!" }
  end
end
