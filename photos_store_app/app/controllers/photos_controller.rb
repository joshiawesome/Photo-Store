class PhotosController < ApplicationController
  def index
    # query all records from the Photo model and assign to @photos instance variable
    @photos = Photo.all
    # respond_to is a method that allows us to respond to different formats
    respond_to do |format|
      format.html
      format.json { render json: @photos }
    end
  end

  def import
    Photos::PhotosImporter.import
    render json: { message: "Photos imported successfully!" }
  end
end
