class Make
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String

  class << self
    attr_accessor :car_moto_makes

    def car_or_motorcycle refresh = false
      self.car_moto_makes = nil if refresh

      return self.car_moto_makes if self.car_moto_makes.present?

      model_ids = Model.car_or_motorcycle.distinct(:_id)
      make_ids = BaseVehicle.where(:model_id => model_ids).distinct(:make_id)
      
      self.car_moto_makes = self.where(:_id => make_ids)
    end
  end
end
