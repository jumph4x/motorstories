namespace :ms do
  namespace :mongo do
    desc "Creating Mongo indices"
    task :ensure_index => :environment do

      User.ensure_index(:username)
      User.ensure_index(:email)
      ProtoVehicle.ensure_index([[:vehicle_type, 1], [:make, 1], [:model, 1], [:year, -1]])
      Vehicle.ensure_index([[:make, 1], [:model, 1], [:year, -1], [:nickname, 1]])
    end
  end

  desc "Initial ProtoVehicle import"
  task :proto_vehicle_import => :environment do
    raise 'ProtoVehicle is alreaddy somewhat populated' if ProtoVehicle.count > 10

    c = AcesCrawler::Conductor.new(concurrency: 5)
    c.total_collection(5).each do |row|
      ProtoVehicle.create(row)
    end
  end
end
