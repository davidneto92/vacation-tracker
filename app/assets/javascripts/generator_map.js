function initGeneratorMap() {
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: { lat: 39.828, lng: -98.579 },
    scaleControl: true
  });
  directionsDisplay.setMap(map);

  var markerList = [];
  var bounds = new google.maps.LatLngBounds();

  var start_point = new google.maps.Marker({
    position: { lat: start_point_json.coords.lat, lng: start_point_json.coords.lng },
    map: map,
    name: start_point_json.address
  });
  loc = new google.maps.LatLng(start_point.position.lat(), start_point.position.lng());
  bounds.extend(loc);

  $.each(found_parks_json, function (x, park) {
    marker = new google.maps.Marker({
      position: { lat: park.latitude, lng: park.longitude },
      // map: map, // skipping this prevents an extra marker, reducing clutter
      label: park.name[0],
      name: park.name,
      park_type: park.park_type
    });
    marker.full_name = marker.name + ' ' + marker.park_type;
    loc = new google.maps.LatLng(marker.position.lat(), marker.position.lng());
    bounds.extend(loc);

    markerList.push(marker);
  });
  map.fitBounds(bounds);
  map.panToBounds(bounds);

  calculateAndDisplayRoute(directionsService, directionsDisplay, markerList);
}

function calculateAndDisplayRoute(directionsService, directionsDisplay, markerList) {
  var markerWaypoints = markerList.map(function(marker) {
    position = {location: marker.full_name, stopover: true};
    return position;
  });
  var destination_position = markerWaypoints.pop();

  directionsService.route({
    origin: start_point_json.address,
    destination: destination_position.location,
    waypoints: markerWaypoints,
    optimizeWaypoints: true,
    travelMode: 'DRIVING'
  }, function(response, status) {
    if (status === 'OK') {
      directionsDisplay.setDirections(response);
      var route = response.routes[0];
    }
  });
}
