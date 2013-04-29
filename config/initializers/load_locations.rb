unless Rails.env.test?
  ll = Motorstories::LocationLoader.new
  ll.populate_locations
end
