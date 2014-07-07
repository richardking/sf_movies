## SF Movies

This app is populated with movie data from the SFData API (https://data.sfgov.org/Arts-Culture-and-Recreation-/Film-Locations-in-San-Francisco/yitu-d5am).

It saves the movies and locations into the database.

Then on the front-end, the user can input a movie title (e.g. 'The Rock'), and the app will mark each of the film's SF locations on a Google map. It also centers the map onto the middle of all of the locations.


### Requirements

* Ruby 2.0 or greater
* mysql

### Deployment

* clone repo
* ```bundle install```
* ```rake db:migrate```
* ```rake db:seed``` (downloads movie data and geolocates the locations)
* ``` rails s```

### API endpoints

#### GET /api/movies

returns an array of all of the movie titles in json format

#### GET /api/movies/:title

returns a hash with:
1) the latitude/longitude the map should center on (based on the average of all the locations)
2) an array of all the locations for that movie- which includes the location name, coordinates and fun fact.
