(function() {
  var showPostExperiences = function() {
    var selectedState = $('#state-select').find('option:selected').val();
    $('.post-experiences').find('li').hide();
    $('.post-experiences').find('.state-' + selectedState).show();
  };

  $(document).ready(function() {
    if ($('.post-experiences').length) {
      var $postExperiences = $('.post-experiences');
      showPostExperiences();

      $('#state-select').change(function() {
        showPostExperiences();
      });
    }

    if ($('#admin-states').length) {
      $('#admin-states').on('change', 'input[type=checkbox]', function() {
        $.ajax({
          url: `/admin/states/${$(this).attr('value')}/toggle`,
          type: 'POST',
          data: {
            done: this.checked
          }
        });
      });
    }

    if ($('#admin-suggestions').length) {
      $('#admin-suggestions').on('change', 'input[type=checkbox]', function() {
        $.ajax({
          url: `/admin/experiences/${$(this).attr('value')}/toggle`,
          type: 'POST',
          data: {
            done: this.checked
          }
        });
      });

      $('#admin-suggestions, #admin-users').on('click', 'a.delete', function(e) {
        e.preventDefault();
        var c = confirm('Are you sure you want to delete this?');
        if (c == true) {
          var row = $(this).closest('tr');
          $.ajax({
            url: $(this).attr('href'),
            type: 'DELETE',
            dataType: 'json',
            success: function(data) {
              if (data.success) {
                row.slideUp('fast', function() {
                  row.remove();
                });
              }
            }
          });
        }
      });
    }

    if ($('#admin-location').length) {
      var search = document.getElementById('admin-location-search');
      var autocomplete = new google.maps.places.Autocomplete(search, {
        componentRestrictions: {
          country: 'us'
        }
      });

      google.maps.event.addListener(autocomplete, 'place_changed', function() {
        var place = autocomplete.getPlace();
        console.log(place);
        var coordinates = [place.geometry.location.A, place.geometry.location.F];
        var address = {};

        jQuery.each(place.address_components, function(k, v1) {
          jQuery.each(v1.types, function(k2, v2) {
            address[v2] = v1.long_name;
          });
        });

        $('#location_name').val('').val(place.name);
        $('#location_lat').val('').val(coordinates[0]);
        $('#location_long').val('').val(coordinates[1]);
        $('#location_formatted_address').val('').val(place.formatted_address);

        if (typeof address.sublocality != 'undefined') {
          $('#location_city').val('').val(address.sublocality);
        } else {
          $('#location_city').val('').val(address.locality);
        }

        $('#state').val('').val(address.administrative_area_level_1);

        if (typeof address.street_number != 'undefined') {
          var streetAddress = address.street_number + ' ' + address.route;
          $('#location_address').val('').val(streetAddress);
        }
      });

      $('#admin-location form').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
          url: $(this).attr('action'),
          type: 'POST',
          dataType: 'json',
          data: $(this).serialize(),
          beforeSend: function() {
            $(this).find('.fa-check-circle').remove();
          },
          success: function(data) {
            if (data.success) {
              location.reload();
            }
          }
        });
      });
    }
  });
})();
