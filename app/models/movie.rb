class Movie < ActiveRecord::Base
  has_and_belongs_to_many :locations
  has_many :movie_participants
  has_many :people, :through => :movie_participants

  belongs_to :production_company, :foreign_key => 'production_company_id', :class => Company
  belongs_to :distributor, :foreign_key => 'distributor_id', :class => Company

  SF_COORDS = [37.7577,-122.4376]

  def build_location_json
    if !locations.empty?
      avg_latitude = locations.map(&:latitude).map(&:to_f).inject(&:+) / locations.size
      avg_longitude = locations.map(&:longitude).map(&:to_f).inject(&:+) / locations.size
    else
      avg_latitude, avg_longitude = SF_COORDS
    end

    locations_ary = locations.map do |l|
      { name: l.name,
        coordinates: [l.latitude, l.longitude],
        fun_fact: l.fun_fact
      }
    end
    Jbuilder.encode do |json|
      json.center [avg_latitude, avg_longitude]
      json.locations locations_ary
    end

  end
end
