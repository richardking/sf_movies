class Geolocator
  attr_reader :url

  def initialize(url='https://maps.googleapis.com/maps/api/geocode/json')
    @url = url
  end

  def geolocate_all
    Location.all.each do |l|
      locate(l)
    end
  end

  private

  def locate(l)
    json = HTTParty.get(url, query: {:address => "#{l.name}, San Francisco, CA", :key => 'AIzaSyCV2-XJy4Sn8VxdUXJnEvIQxShqQYIPObI'})
    if json['results'].first
      l.update_attribute(:latitude, json['results'].first['geometry']['location']['lat'])
      l.update_attribute(:longitude, json['results'].first['geometry']['location']['lng'])
    end
  end
end
