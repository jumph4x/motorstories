class Profile
  include MongoMapper::Document

  key :username, String, :required => true, :unique => true
  key :instagram_handle, String
  key :facebook_handle, String
  key :tumblr_handle, String
  key :location_id, Integer

  timestamps!

  validate :location_validity

  def location
    location_id && Location.find_by_id(location_id)
  end

  private

  def location_validity
    errors.add(:location_id, "Please specify your location") unless location
  end
end
