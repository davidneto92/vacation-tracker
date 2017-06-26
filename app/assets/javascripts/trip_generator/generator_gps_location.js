$(document).ready(function(){
  gpsButton = document.getElementById('gpsButton');
  document.getElementById('gpsButton').disabled = false;

  gpsButton.addEventListener("click", function(){
    event.preventDefault();
    var userCoords = geolocate();
  });

});
