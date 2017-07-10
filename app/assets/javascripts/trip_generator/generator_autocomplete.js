var placeSearch, autocomplete;

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.
  autocompleteStart = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
      {types: ['geocode']});

  autocompleteDestination = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete-destination')),
      {types: ['geocode']});
}
