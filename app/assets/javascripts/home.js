$(function(){
  var map;
  var markers = [];
  var SF_LAT = 37.7577;
  var SF_LNG = -122.4376;

  function deleteMarkers() {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }
    markers = [];
  }

  function addMarker(location, title) {
    var marker = new google.maps.Marker({
      position: location,
        map: map,
        title: title
    });
    markers.push(marker);
  }

  function searchMovie() {
    deleteMarkers();

    $.get("/api/movies/" + $("#movie").val(), function (data) {
      var locations_ary = data.locations;
      var center_coords = new google.maps.LatLng(data.center[0], data.center[1]);
      var myLatlng;
      map.panTo(center_coords);
      for (var i = 0; i < locations_ary.length; i++) {
        myLatlng = new google.maps.LatLng(locations_ary[i].coordinates[0], locations_ary[i].coordinates[1]);
        addMarker(myLatlng, locations_ary[i].name);
      }
    });
  }

  function initialize() {
    $.get("/api/movies", function( movieTitles ) {
      $( "#movie" ).autocomplete({
        source: movieTitles
      });
    });
    var mapOptions = {
      center: new google.maps.LatLng(SF_LAT, SF_LNG),
      zoom: 12
    };
    map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    $(document).on("submit", "form", function() {
      searchMovie();
      return false;
    });

    $(document).on("click", "#submit", function () {
      searchMovie();
    });
  }
  google.maps.event.addDomListener(window, "load", initialize);
});
