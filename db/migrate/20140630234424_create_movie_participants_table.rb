class CreateMovieParticipantsTable < ActiveRecord::Migration
  def change
    create_table :movie_participants do |t|
      t.integer :movie_id
      t.integer :person_id
      t.integer :role_id

      t.timestamps
    end

    add_index :movie_participants, [:movie_id, :person_id, :role_id], :unique => true
  end
end
