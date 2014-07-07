class Location < ActiveRecord::Base
  has_and_belongs_to_many :movies

  def build_hash
    {
      name: name,
      coordinates: [latitude, longitude],
      fun_fact: fun_fact
    }
  end
end
