table "base_vehicles" do
	column "id", :key, :as => :integer
	column "year", :integer
	column "make_id", :integer, :references => "makes"
	column "model_id", :integer, :references => "models"
end

table "makes" do
	column "id", :key, :as => :integer
	column "name", :string
end

table "models" do
	column "id", :key, :as => :integer
	column "name", :string
	column "vehicle_type_id", :integer
end
