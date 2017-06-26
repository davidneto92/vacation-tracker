$(document).ready(function(){
  var gpsButton = document.getElementById('parkFindButton');
  if (gpsButton !== null) {
    gpsButton.disabled = false;

    gpsButton.addEventListener("click", function(){
      event.preventDefault();
      userCoordinates();
    });
  }
});

function userCoordinates() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      findParks(geolocation);

    });
  }
}

function between(x, min, max) {
  return x >= min && x <= max;
}

function findParks(coordinates) {
  var foundParks = [];
  $.ajax({
    method: 'GET',
    url: '/api/v1/parks',
    success: function success(parks) {
      $.each(parks, function (x, park) {
        if (between(coordinates.lat, park.latitude - 0.4, park.latitude + 0.4) && between(coordinates.lng, park.longitude - 0.4, park.longitude + 0.4) ) {
          foundParks.push(park);
        }
      });
      debugger;
      // TODO:
      // send list to method that can present the parks
      // list should be presented a list of buttons
      // clicking a button will close the window and change the select box to the corresponding choice
    }
  });
}
