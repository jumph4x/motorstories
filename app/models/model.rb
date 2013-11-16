class Model
  include MongoMapper::Document

  has_many :base_vehicles

  key :name, String
  key :vehicle_type_id, Integer

  scope :car_or_motorcycle, where(:vehicle_type_id => VehicleType.data.keys )

  def vehicle_type
    vehicle_type_id && VehicleType.find_by_id(vehicle_type_id)
  end

  def chassis_type
    vehicle_type && vehicle_type.name
  end

  class << self
    def by_make_id make_id
      model_ids = BaseVehicle.where(:make_id => make_id).distinct(:model_id)
      car_or_motorcycle.sort(:name).where(:_id => model_ids)
    end

    def find_by_make_id_and_slug make_id, slug
      hit = nil

      by_make_id(make_id).each do |modell|
        if modell.name.to_url == slug
          hit = modell
          break
        end
      end

      hit
    end
  end
end
