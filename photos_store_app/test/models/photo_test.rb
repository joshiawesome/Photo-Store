require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  test "should save photo with valid attributes" do
    photo = Photo.new(
      external_id: "1",
      title: "Test Photo"
    )

    assert photo.save
  end

  test "should not save photo without external_id" do
    photo = Photo.new(title: "Test Photo")
    
    assert_not photo.save
  end

  test "should not save photo without title" do
    photo = Photo.new(external_id: "1")
    
    assert_not photo.save
  end

  test "should not save photo with duplicate external_id" do
    photo = Photo.new(external_id: "1", title: "Test Photo")
    photo.save
    
    photo2 = Photo.new(external_id: "1", title: "Test Photo")
    
    assert_not photo2.save
  end
end
