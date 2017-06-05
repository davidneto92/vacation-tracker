// trying to use an ES5 version to see if it will compile with heroku

function initVacationMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 8,
    center: { lat: window.map_center[0], lng: window.map_center[1] },
    mapTypeId: 'terrain',
    scaleControl: true
  });

  var markerList = [];
  var bounds = new google.maps.LatLngBounds();

  $.ajax({
    method: 'GET',
    url: '/api/v1/visits',
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
      });

      // prevents excessive zoom if there is only 1 visit
      if (markerList.length > 1) {
        map.fitBounds(bounds);
        map.panToBounds(bounds);
      }

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
  });
}
