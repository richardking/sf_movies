class MovieImporter
  attr_reader :url

  def initialize(url='http://data.sfgov.org/resource/yitu-d5am.json')
    @url = url
  end

  def import_all
    json = HTTParty.get url
    json.each do |j|
      next unless j['title'] && j['locations']
      import_movie(j)
    end
  end

  private

  def import_movie(j)
    m = Movie.find_or_create_by(title: j['title'])
    m.release_year = j['release_year']

    location = Location.find_or_initialize_by(name: j['locations'])
    location.fun_fact = j['fun_facts']
    location.save

    m.locations << location

    m.save
  end
end
