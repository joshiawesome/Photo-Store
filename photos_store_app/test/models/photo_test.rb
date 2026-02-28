require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  test "should save photo with valid attributes" do
    photo = Photo.new(
      external_id: "1",
      name: "Test Photo"
    )

    assert photo.save
  end

  test "should not save photo without external_id" do
    photo = Photo.new(name: "Test Photo")
    
    assert_not photo.save
  end

  test "should not save photo without name" do
    photo = Photo.new(external_id: "1")
    
    assert_not photo.save
  end

  test "should not save photo with duplicate external_id" do
    photo = Photo.new(external_id: "1", name: "Test Photo")
    photo.save
    
    photo2 = Photo.new(external_id: "1", name: "Test Photo")
    
    assert_not photo2.save
  end
end

