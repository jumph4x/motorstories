MongoMapper.connection = Mongo::Connection.new('localhost', 27017, :logger => nil)

module MongoMapper
  module Plugins
    module Accessible
      def assign_attributes(new_attributes, options={})
        self.attributes=(new_attributes)
      end
    end
  end
end
