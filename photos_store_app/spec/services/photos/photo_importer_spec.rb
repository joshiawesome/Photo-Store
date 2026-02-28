require 'rails_helper'

# note: do not call actual API for tests
# call the actual API for integration tests
RSpec.describe Photos::PhotosImporter, type: :service do
    # the below syntax is equivalent to a method return value
    let(:api_base_url) {"https://test_api.com"}
    let(:api_token) {"test_token"}
    let(:url) {"#{api_base_url}/collections/all/products?storefront_token=#{api_token}"}

    let(:api_response) do 
        {
            # => creates a string key
            # : creates a symbol key
            # json needs string keys so we use =>
            "results" => [
                {
                    "id" => "1",
                    "name" => "Sunset",
                    "price" => "10.00",
                    "image_url" => "https://test_api.com/sunset_image.jpg"
                },
                {
                    "id" => "2",
                    "name" => "Ocean",
                    "price" => "10.00",
                    "image_url" => "https://test_api.com/ocean_image.jpg"
                }
            ]
        }
    end

    # before means run 'before' each test case; i.e before each 'it' block
    before do 
        # delete all photos before each test case
        Photo.delete_all

        # inject/stub the .env variables with mock values
        stub_const("ENV", ENV.to_hash.merge( "API_BASE_URL" => api_base_url, "API_TOKEN" => api_token ))
        # stub the HTTP request
        # :get acts like an enum type for HTTP methods
        # the response is mocked

        stub_request(:get, url)
        .to_return(
            status: 200,
            body: api_response.to_json,
            headers: { 'Content-Type' => 'application/json' }
        )
    end

    # write the actual test cases
    describe ".import" do
        it "create new photos in the database" do
            described_class.import
            expect(Photo.count).to eq(2)
        end

        it "updates existing photos in the database" do
            photo = Photo.create!(external_id: "1", name: "Sunset", price: "10.00", image_url: "https://test_api.com/sunset_image.jpg")
            described_class.import
            expect(photo.reload.name).to eq("Sunset")
        end

        it "throws an error if the API request fails" do
            # stub the database save to fail
            allow_any_instance_of(Photo)
            .to receive(:save!)
            .and_raise(ActiveRecord::RecordInvalid)

            expect { described_class.import }.to raise_error(ActiveRecord::RecordInvalid)
        end
    end

end


 
    




    