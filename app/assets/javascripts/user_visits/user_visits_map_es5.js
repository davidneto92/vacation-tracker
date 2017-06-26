function initUserMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 3,
    center: { lat: 49.544, lng: -121.595 },
    mapTypeId: 'terrain',
    scaleControl: true
  });

  var markerList = [];

  $.ajax({
    method: 'GET',
    url: '/api/v1/user_visits/' + user_id,
    success: function success(parks) {
      $.each(parks, function (x, park) {
        if (park.visited === true) {
          marker = new google.maps.Marker({
            position: { lat: park.latitude, lng: park.longitude },
            map: map,
            full_name: park.full_name,
            park_id: park.park_id,
            visited: true,
            vacation_id: park.most_recent_vacation_id,
            vacation_name: park.most_recent_vacation_name,
            icon: 'https://s3.amazonaws.com/vacation-tracker/support/map-marker-visited-02.png'
          });
        } else {
          marker = new google.maps.Marker({
            position: { lat: park.latitude, lng: park.longitude },
            map: map,
            full_name: park.full_name,
            park_id: park.park_id,
            visited: false,
            icon: 'https://s3.amazonaws.com/vacation-tracker/support/map-marker-not-visited.png'
          });
        }
        markerList.push(marker);
      });

      var _loop = function _loop(i) {
        var infowindow = undefined;
        contentBase = '<div class="text-center"><strong><a href="https://track-vacations.herokuapp.com/parks/' + markerList[i].park_id + '">' + markerList[i].full_name + '</a></strong><br>';
        if (markerList[i].visited === true) {
          infowindow = new google.maps.InfoWindow({
            content: contentBase + 'Last Visit: <a href="https://track-vacations.herokuapp.com/vacations/' + markerList[i].vacation_id + '">' + markerList[i].vacation_name + '</a></div>'
          });
        } else {
          infowindow = new google.maps.InfoWindow({
            content: contentBase + '</div>'
          });
        }

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
