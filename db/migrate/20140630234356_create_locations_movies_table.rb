class CreateLocationsMoviesTable < ActiveRecord::Migration
  def change
    create_table :locations_movies do |t|
      t.belongs_to :movie
      t.belongs_to :location
    end
  end
end
