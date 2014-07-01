class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :release_year
      t.integer :production_company_id
      t.integer :distributor_id
      t.integer :director_id
      t.integer :writer_id

      t.timestamps
    end
  end
end
