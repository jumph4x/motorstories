module Motorstories
  class LocationLoader
    attr_accessor :cached_locations_hash
    class << self
      attr_accessor :cached_cipher_data
    end
    
    def populate_locations
      Location.data = locations_hash
      true
    end

    def locations_hash
      return cached_locations_hash if cached_locations_hash.present?

      locations = {}
      Craigslist.cities.each do |city|
        key = hash_name(city)

        locations[key] = {
          :name => decorate_name(city),
          :id => key
        }
      end

      cached_cipher_data = locations
    end

    def hash_name city_name
      raise "No name supplied" unless city_name.present?
      
      cipher_string = city_name.
        split(//).
        map{|c| LocationLoader.cipher_data[c] }.
        join

      cipher_string.to_i
    end

    def decorate_name city_name
      raise "No name supplied" unless city_name.present?

      new_name = city_name.titleize
      new_name.scan(/\b[A-Z][a-z]\b/).each do |abbr|
        new_name.gsub!(abbr, abbr.upcase)
      end

      new_name
    end

    def self.cipher_data
      return cached_cipher_data if cached_cipher_data.present?
      
      hash = {}
      variety = ('a'..'z').to_a
      variety += [' ', '-', '_']
      
      variety.each_with_index do |letter, i|
        hash[letter] = hash[letter.upcase] = i.to_s[-1].to_i
      end

      cached_cipher_data = hash
    end
  end
end
