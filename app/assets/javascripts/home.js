var map;
var markers = [];
var availableTags;

$(document).on("submit", "form", function() {
  searchMovie();
  return false;
});

$(document).on("click", "#submit", function () {
  searchMovie();
});

function searchMovie() {
  deleteMarkers();

  $.get("/api/movies/"+$("#movie").val(), function( data ) {
    var locations_ary = data.locations;
    var center_coords = new google.maps.LatLng(data.center[0], data.center[1]);
    map.panTo(center_coords);
    for ( var i = 0; i < locations_ary.length; i++ ) {
      var myLatlng = new google.maps.LatLng(locations_ary[i].coordinates[0], locations_ary[i].coordinates[1]);
      addMarker(myLatlng, locations_ary[i].name);
    }
  })
}

function setAllMap(map) {
  for ( i = 0; i < markers.length; i++ ) {
    markers[i].setMap(map);
  }
}


function addMarker(location, title) {
  var marker = new google.maps.Marker({
    position: location,
      map: map,
      title: title
  });
  markers.push(marker);
}

function clearMarkers() {
  setAllMap(null)
}

function deleteMarkers() {
  clearMarkers();
  markers = [];
}

function initialize() {
  $.get("/api/movies", function( data ) {
    availableTags = data
    $( "#movie" ).autocomplete({
      source: availableTags
    });
  })
  var mapOptions = {
    center: new google.maps.LatLng(37.7577, -122.4376),
    zoom: 12
  };
  map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);
}
google.maps.event.addDomListener(window, "load", initialize);
