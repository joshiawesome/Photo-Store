require "test_helper"

class AdditionalInformationTest < ActiveSupport::TestCase
  test "belongs to product association definition" do
    assoc = AdditionalInformation.reflect_on_association(:product)
    assert_equal :belongs_to, assoc.macro
  end

  test "belongs to product in practice" do
    product = Product.create!(id: 'lego', name:'Lego')
    
    additional_information = AdditionalInformation.create!(product: product)
    
    assert_equal product, additional_information.product
  end
end
