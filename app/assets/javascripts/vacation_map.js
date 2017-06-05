function initMap() {
  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 8,
    center: {lat: window.map_center[0], lng: window.map_center[1]},
    mapTypeId: 'terrain',
    scaleControl: true
  });

  markerList = [];
  bounds  = new google.maps.LatLngBounds();

  $.ajax({
    method: 'GET',
    url: '/api/v1/visits',
    success: function success(visits) {
      $.each(visits, function (x, visit) {
        if (visit.vacation_id === window.vacation_id) {
          marker = new google.maps.Marker({
            position: {lat: visit.lat, lng: visit.lng},
            label: visit.park_name[0],
            map: map,
            name: visit.park_name,
            date: visit.visit_date
          });

          loc = new google.maps.LatLng(marker.position.lat(), marker.position.lng());
          bounds.extend(loc);

          markerList.push(marker);
        }
      });

      // prevents excessive zoom if there is only 1 visit
      if (markerList.length > 1) {
        map.fitBounds(bounds);
        map.panToBounds(bounds);
      }

      for (let i = 0; i < markerList.length; i++) {
        let infowindow = new google.maps.InfoWindow({
          content: `<div class="text-center"><strong>${markerList[i].name}</strong><br>${markerList[i].date}</div>`
        });

        markerList[i].addListener('click', function() {
          infowindow.open(map, markerList[i]);
        });
      }

    }
  });

}
