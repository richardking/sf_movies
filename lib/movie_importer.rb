class MovieImporter
  attr_reader :url

  def initialize(url='http://data.sfgov.org/resource/yitu-d5am.json')
    @url = url
  end

  def import
    json = HTTParty.get url
    json.each do |j|
      m = Movie.find_or_create_by(title: j['title'])
      m.release_year = j['release_year']
      if j['director']
        director = Person.find_or_initialize_by(name: j['director'])
        director.save
        MovieParticipant.find_or_create_by(movie_id: m.id, person_id: director.id, role_id: 1)
      end

      if j['writer']
        writer = Person.find_or_initialize_by(name: j['writer'])
        writer.save
        MovieParticipant.find_or_create_by(movie_id: m.id, person_id: writer.id, role_id: 2)
      end

      if j['locations']
        location = Location.find_or_initialize_by(name: j['locations'])
        location.fun_fact = j['fun_facts']
        location.save

        m.locations << location
      end

      if j['production_company']
        production_company = Company.find_or_initialize_by(name: j['production_company'])
        production_company.save
        m.production_company_id = production_company.id
      end

      if j['distributor']
        distributor = Company.find_or_initialize_by(name: j['distributor'])
        distributor.save
        m.distributor_id = distributor.id
      end

      m.save
    end
  end

  def geolocate
    Location.all.each do |l|
      i = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json", query: {:address => "#{l.name}, San Francisco, CA", :key => "AIzaSyCV2-XJy4Sn8VxdUXJnEvIQxShqQYIPObI"})
      puts i["results"].first
      l.update_attribute(:latitude, i["results"].first["geometry"]["location"]["lat"])
      l.update_attribute(:longitude, i["results"].first["geometry"]["location"]["lng"])
    end
  end
end
