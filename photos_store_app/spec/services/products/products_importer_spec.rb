# spec/services/products/product_importer_spec.rb
require 'rails_helper'

# note: do not call actual API for tests
# call the actual API for integration tests
RSpec.describe Products::ProductsImporter do
  describe '.import' do
    let(:api_base_url) { 'https://fake-api.com' }
    let(:api_token) { 'fake-token' }
    let(:api_response) do
      {
        "results" => [
          {
            "id" => "prod_1",
            "name" => "Product 1",
            "slug" => "product-1",
            "description" => "A product",
            "state" => "active",
            "access" => "public",
            "created_at" => "2026-03-25T00:00:00Z",
            "updated_at" => "2026-03-25T00:00:00Z",
            "images" => [
              { "id" => "img_1", "url" => "http://example.com/img1.png", "transformedUrl" => "http://example.com/img1_transformed.png", "width" => 100, "height" => 200 }
            ],
            "variants" => [
              {
                "id" => "var_1",
                "name" => "Variant 1",
                "sku" => "SKU1",
                "unitPrice" => { "value" => 10.0, "currency" => "USD" },
                "compareAtPrice" => { "value" => 12.0, "currency" => "USD" },
                "stock" => { "type" => "in_stock" },
                "weight" => { "value" => 1.0, "unit" => "kg" },
                "dimensions" => { "length" => 10, "width" => 5, "height" => 2, "unit" => "cm" },
                "attributes" => { "description" => "Variant description", "color" => { "name" => "Red", "swatch" => "#ff0000" }, "size" => { "name" => "M" } },
                "images" => [
                  { "id" => "var_img_1", "url" => "http://example.com/var_img1.png", "transformedUrl" => "http://example.com/var_img1_transformed.png", "width" => 50, "height" => 50 }
                ]
              }
            ],
            "additionalInformation" => [
              { "id" => "info_1", "type" => "care", "title" => "Care instructions", "bodyHtml" => "<p>Wash carefully</p>" }
            ]
          }
        ]
      }
    end

    # before means run 'before' each test case; i.e before each 'it' block
    before do
      # inject/stub the .env variables with mock values
      stub_const('ENV', ENV.to_hash.merge('API_BASE_URL' => api_base_url, 'API_TOKEN' => api_token))
      stub_request(:put, /localhost:9200/).to_return(status: 200, body: "")
    stub_request(:post, /localhost:9200/).to_return(status: 200, body: "")

      # stub the HTTP request
      # :get acts like an enum type for HTTP methods
      # the response is mocked
      allow(HTTParty).to receive(:get).and_return(double(parsed_response: api_response))
    end

    it 'hydrates the products table' do
      expect { described_class.import }.to change(Product, :count).by(1)
      # the above snippet can also be written as
      #    described_class.import
      #    expect(Product.count).to eq(1)

      
      # Product is the model class
      # product is the instance of Product - represents a row
      # products refers to multiple instances of Product - represents rows
      # like how product.variants means multiple variant instances/rows of the a product
      product = Product.first
      expect(product.name).to eq("Product 1")
      expect(product.images.count).to eq(1)
      expect(product.variants.count).to eq(1)
      expect(product.additional_informations.count).to eq(1)

      variant = product.variants.first
      expect(variant.variant_attribute.description).to eq("Variant description")
      expect(variant.images.count).to eq(1)
    end

    it 'does not call the real API' do
      described_class.import
      expect(HTTParty).to have_received(:get).once
    end

    it "raises an error if saving a product fails" do
      # stub the first Product instance to fail on save!
      allow_any_instance_of(Product)
        .to receive(:save!)
        .and_raise(ActiveRecord::RecordInvalid.new(Product.new))

      expect { described_class.import }.to raise_error(ActiveRecord::RecordInvalid)
   end
  end
end


 
    




    