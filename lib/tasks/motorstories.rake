namespace :ms do
  namespace :mongo do
    desc "Creating Mongo indices"
    task :create_indices => :environment do

      User.ensure_index(:username)
      User.ensure_index(:location_id)
    end
  end
end
