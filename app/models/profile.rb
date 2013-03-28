class Profile < ActiveRecord::Base
  attr_accessible :facebook_username, :instagram_username, :location_id, :twitter_username, :user_id
end
