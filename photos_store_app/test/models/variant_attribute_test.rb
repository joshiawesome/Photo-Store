require "test_helper"

class VariantAttributeTest < ActiveSupport::TestCase
  test "belongs to variant association definition" do
    assoc = VariantAttribute.reflect_on_association(:variant)
    assert_equal :belongs_to, assoc.macro
  end

  test "belongs to variant in practice" do
    product = Product.create!(id: 'lego', name:'Lego')
    variant = Variant.create!(id: 'lego_city', product: product, name:'Lego City')
    
    variant_attribute = VariantAttribute.create!(variant: variant, color_swatch: 'matte black')
    
    assert_equal variant, variant_attribute.variant
  end
end
