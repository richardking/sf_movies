class Person < ActiveRecord::Base
  has_many :movie_participants
  has_many :movies, :through => :movie_participants
  has_many :roles, :through => :movie_participants
end
