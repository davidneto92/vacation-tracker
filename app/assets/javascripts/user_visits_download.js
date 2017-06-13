$(document).ready(function(){
  download_button = document.getElementById("map-download-button");
  download_button.addEventListener("click", function(){
    event.preventDefault();

    $.ajax({
      method: 'GET',
      url: '/users/' + user_id + '/user_visits_download',
      success: function success(map_data) {
        window.scrollBy(0, 200);
        download_area = document.getElementById("download-link-area");
        MotionUI.animateIn(download_area, 'fade-in');
        download_area.innerHTML += '<br>Download link:<br><a class="button success" href="' + download_path + '" download>Click to Download .KML</a>' ;

        $(document.getElementById("map-download-button")).addClass("disabled");
      }
    });

  });

});
