class Role < ActiveRecord::Base
  has_many :movie_participants
  has_many :people, :through => :movie_participants
end
