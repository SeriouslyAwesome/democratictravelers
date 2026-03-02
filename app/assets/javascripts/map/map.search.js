(function() {
  DemocraticTravelers.Map.Search = {
    initialize: function(map) {
      var search = document.getElementById('location-search');
      var autocomplete = new google.maps.places.Autocomplete(search, {
        componentRestrictions: {
          country: 'us'
        }
      });

      var self = this;
      google.maps.event.addListener(autocomplete, 'place_changed', () => {
        var place = autocomplete.getPlace();
        self.selectPlace(place);
      });
    },

    selectPlace: function(place) {
      var lat = place.geometry.location.lat();
      var lng = place.geometry.location.lng();
      var address = {};

      jQuery.each(place.address_components, function(k, v1) {
        jQuery.each(v1.types, function(k2, v2) {
          address[v2] = v1.long_name;
        });
      });

      this.setFormFields(place, [lat, lng], address);
      this.showOnMap([lng, lat]);
    },

    setFormFields: function(place, coordinates, address) {
      $('#suggestion_location_name').val('').val(place.name);
      $('#suggestion_latitude').val('').val(coordinates[0]);
      $('#suggestion_longitude').val('').val(coordinates[1]);
      $('#suggestion_formatted_address').val('').val(place.formatted_address);

      if (typeof address.sublocality != 'undefined') {
        $('#suggestion_city').val('').val(address.sublocality);
      } else {
        $('#suggestion_city').val('').val(address.locality);
      }

      $('#suggestion_state').val('').val(address.administrative_area_level_1);

      if (typeof address.postal_code != 'undefined') {
        $('#suggestion_zip').val('').val(address.postal_code);
      }

      if (typeof address.street_number != 'undefined') {
        var streetAddress = address.street_number + ' ' + address.route;
        $('#suggestion_address').val('').val(streetAddress);
      }
    },

    showOnMap: function(lngLat) {
      DemocraticTravelers.Map.clearSearchMarker();

      var el = document.createElement('div');
      el.className = 'map-pin map-pin-search';
      el.innerHTML = '<span><i class="fa fa-search"></i></span>';

      DemocraticTravelers.Map.searchMarker = new mapboxgl.Marker({ element: el, anchor: 'bottom' })
        .setLngLat(lngLat)
        .addTo(DemocraticTravelers.Map.mapObject);

      DemocraticTravelers.Map.mapObject.flyTo({ center: lngLat, zoom: 12 });
    }
  };
})();
