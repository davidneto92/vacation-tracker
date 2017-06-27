$(document).ready(function(){
  var gpsButton = document.getElementById('parkFindButton');
  if (gpsButton !== null) {
    gpsButton.disabled = false;

    gpsButton.addEventListener("click", function(){
      event.preventDefault();
      userCoordinates();
      // gpsButton.disabled = true;
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
        // searches a 25 mile area around user's location
        if (between(coordinates.lat, park.latitude - 0.45, park.latitude + 0.45) && between(coordinates.lng, park.longitude - 0.45, park.longitude + 0.45) ) {
          foundParks.push(park);
        }
      });
      displayFoundParks(foundParks);
      tieButtonsToList(foundParks);
    }
  });
}

function displayFoundParks(foundParks) {
  resultsDisplay = document.getElementById('foundParksDiv');
  resultsDisplay.innerHTML = '';

  buttonStartText = '<div class="row text-center"><div class="columns small-12"><span type="button" class="button expanded" ';
  buttonEndText   = '</span></div></div>';

  resultsDisplay.innerHTML = '<p class="text-center">Found Park(s)</p>';

  if (foundParks.length > 0) {
    MotionUI.animateIn(resultsDisplay, 'fade-in');
    $.each(foundParks, function (x, park) {
      resultsDisplay.innerHTML += (buttonStartText + 'id="result' + park.id + '">' + park.name + ' ' + park.park_type + buttonEndText);
    });
  } else {
    resultsDisplay.innerHTML = '<p class="text-center">No parks found near your location. Please try again.</p>';
  }
}

function tieButtonsToList(foundParks) {
  var dropdownList = document.getElementById('park-visit-list');

  $.each(foundParks, function (x, park) {
    button = document.getElementById('result' + park.id);
    button.addEventListener("click", function(){
      dropdownList.selectedIndex = park.id - 1;
      resultsDisplay = document.getElementById('foundParksDiv');
      MotionUI.animateOut(resultsDisplay, 'fade-out');
    });
  });

}
