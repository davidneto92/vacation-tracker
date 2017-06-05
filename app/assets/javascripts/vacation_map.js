function initMap() {
  let map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: {lat: window.map_center[0], lng: window.map_center[1]},
    mapTypeId: 'terrain',
    scaleControl: true
  });
  console.log("map generated");

  markerList = [];

  $.ajax({
    method: 'GET',
    url: '/api/v1/visits',
    success: function success(visits) {
      $.each(visits, function (x, visit) {
        if (visit.vacation_id === vacation_id) {
          markerList.push(
            new google.maps.Marker({
              position: {lat: visit.lat, lng: visit.lng},
              label: visit.park_name[0],
              map: map,
              name: visit.park_name,
              date: visit.visit_date
            })
          );
          console.log("marker created");
        }
      });

      for (let i = 0; i < markerList.length; i++) {
        let infowindow = new google.maps.InfoWindow({
          content: `<div class="text-center"><strong>${markerList[i].name}</strong><br>${markerList[i].date}</div>`
        });

        markerList[i].addListener('click', function() {
          infowindow.open(map, markerList[i]);
        });
        console.log("event listener created");
      }

    }
  });

}
