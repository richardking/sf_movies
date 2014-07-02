class Geolocator
  attr_reader :url

  def initialize(url='https://maps.googleapis.com/maps/api/geocode/json')
    @url = url
  end

  def geolocate_all
    Location.where("latitude is ? OR longitude is ?", nil, nil).each do |l|
      locate(l)
    end

    clean_up
  end

  private

  def locate(l)
    json = get_json(l.name)
    if json['results'].first
      l.update_attribute(:latitude, json['results'].first['geometry']['location']['lat'])
      l.update_attribute(:longitude, json['results'].first['geometry']['location']['lng'])
    else
      l.destroy
    end
  end

  def get_json(location_name)
    HTTParty.get(url, query: {:address => "#{location_name}, San Francisco, CA", :key => 'AIzaSyCV2-XJy4Sn8VxdUXJnEvIQxShqQYIPObI'})
  end

  def clean_up
    Movie.all.each { |m| m.destroy if m.locations.empty? }
  end
end
