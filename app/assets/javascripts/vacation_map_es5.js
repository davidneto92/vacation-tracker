// Converted from ES6 to ES5 to make compatible with Heroku
var markerList = [];
var bounds;

function initVacationMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 8,
    center: { lat: window.map_center[0], lng: window.map_center[1] },
    mapTypeId: 'terrain',
    scaleControl: true
  });

  bounds = new google.maps.LatLngBounds();

  $.ajax({
    method: 'GET',
    url: '/api/v1/vacations/' + vacation_id,
    success: function success(visits) {
      $.each(visits, function (x, visit) {
        if (visit.vacation_id === window.vacation_id) {
          marker = new google.maps.Marker({
            position: { lat: visit.lat, lng: visit.lng },
            map: map,
            label: visit.full_name[0],
            name: visit.name,
            full_name: visit.full_name,
            date: visit.visit_date
          });

          loc = new google.maps.LatLng(marker.position.lat(), marker.position.lng());
          bounds.extend(loc);

          markerList.push(marker);
        }
        buildParkInfoWindows();
      });
    }
  });
  var geocoder = new google.maps.Geocoder();
  geocodeVacationLocation(geocoder, map);
}

function buildParkInfoWindows() {
  var _loop = function _loop(i) {
    var infowindow = new google.maps.InfoWindow({
      content: '<div class="text-center"><strong>' + markerList[i].full_name + '</strong><br>' + markerList[i].date + '</div>'
    });

    markerList[i].addListener('click', function () {
      infowindow.open(map, markerList[i]);
    });
  };

  for (var i = 0; i < markerList.length; i++) {
    _loop(i);
  }
}

function geocodeVacationLocation(geocoder, map) {
  geocoder.geocode({'address': vacation_location}, function(results, status) {
    if (status === 'OK') {
      var geocode_lat = results[0].geometry.location.lat();
      var geocode_lng = results[0].geometry.location.lng();
      var marker = new google.maps.Marker({
        map: map,
        position: { lat: Number(geocode_lat.toFixed(3)), lng: Number(geocode_lng.toFixed(3)) },
      });
      loc = new google.maps.LatLng(marker.position.lat(), marker.position.lng());
      bounds.extend(loc);
      setMapBounds(map, bounds);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function setMapBounds(map, bounds) {
  // prevents excessive zoom if there is only 1 visit
  if (markerList.length > 1) {
    map.fitBounds(bounds);
    map.panToBounds(bounds);
  }
}
