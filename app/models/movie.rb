class Movie < ActiveRecord::Base
  has_and_belongs_to_many :locations
  has_many :movie_participants
  has_many :people, :through => :movie_participants

  belongs_to :production_company, :foreign_key => 'production_company_id', :class => Company
  belongs_to :distributor, :foreign_key => 'distributor_id', :class => Company
end
