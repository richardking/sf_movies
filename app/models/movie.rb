class Movie < ActiveRecord::Base
  has_and_belongs_to_many :locations

  def build_json
    avg_latitude = locations.map(&:latitude).map(&:to_f).inject(&:+) / locations.size
    avg_longitude = locations.map(&:longitude).map(&:to_f).inject(&:+) / locations.size

    locations_ary = locations.map { |l| l.build_hash }

    Jbuilder.encode do |json|
      json.center [avg_latitude, avg_longitude]
      json.locations locations_ary
    end
  end
end
