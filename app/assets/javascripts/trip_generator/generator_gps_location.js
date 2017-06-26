// TODO:
// convert coodinates into string
// return string to be entered into fields
$(document).ready(function(){
  gpsButton = document.getElementById('gpsButton');
  if (gpsButton !== null) {
    document.getElementById('gpsButton').disabled = false;

    gpsButton.addEventListener("click", function(){
      event.preventDefault();
      geolocate();
    });
  }
});

function geolocate() {
  var geocoder = new google.maps.Geocoder();
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      geocodeLatLng(geocoder, geolocation);
    });
  }
}

function geocodeLatLng(geocoder, geolocation) {
  geocoder.geocode({'location': geolocation}, function(results, status) {
    if (status === 'OK') {
      addressString = results[0].formatted_address;
      inputField = document.getElementById('autocomplete');
      inputField.value = addressString;
    } else {
      window.alert('Geocoder failed due to: ' + status);
    }
  });
}
