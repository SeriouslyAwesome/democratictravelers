showPostExperiences = -> 
  selectedState = $('#state-select').find('option:selected').val()
  $('.post-experiences').find('li').hide()
  $('.post-experiences').find('.state-' + selectedState).show()

jQuery ->
  if $('.post-experiences').length
    $postExperiences = $('.post-experiences')
    showPostExperiences()

    $('#state-select').change ->
      showPostExperiences()

  if $('#admin-states').length
    # Mark states as done!
    $('#admin-states').on 'change', 'input[type=checkbox]', ->
      $.ajax
        url: "/admin/states/#{$(this).attr('value')}/toggle"
        type: 'POST'
        data:
          done: this.checked

  if $('#admin-suggestions').length
    # Mark suggestions as done!
    $('#admin-suggestions').on 'change', 'input[type=checkbox]', ->
      $.ajax
        url: "/admin/experiences/#{$(this).attr('value')}/toggle"
        type: 'POST'
        data:
          done: this.checked

    # Delete stuff!
    $('#admin-suggestions, #admin-users').on 'click', 'a.delete', (e) ->
      e.preventDefault()
      c = confirm 'Are you sure you want to delete this?'
      if c == true
        row = $(this).closest('tr')
        $.ajax
          url: $(this).attr('href')
          type: 'DELETE'
          dataType: 'json'
          success: (data) ->
            if data.success
              row.slideUp 'fast', ->
                row.remove()

  if $('#admin-location').length
    # Set current location!
    search = document.getElementById 'admin-location-search'
    autocomplete = new google.maps.places.Autocomplete search,
      componentRestrictions:
          country: 'us'

    google.maps.event.addListener autocomplete, 'place_changed', ->
      place = autocomplete.getPlace()
      coordinates = [place.geometry.location.k, place.geometry.location.A]
      address = {}

      jQuery.each place.address_components, (k,v1) ->
        jQuery.each v1.types, (k2, v2) ->
          address[v2] = v1.long_name

      $('#location_name').val('').val(place.name)
      $('#location_lat').val('').val(coordinates[0])
      $('#location_long').val('').val(coordinates[1])
      $('#location_formatted_address').val('').val(place.formatted_address)

      if (typeof address.sublocality != 'undefined')
        $('#location_city').val('').val(address.sublocality)
      else
        $('#location_city').val('').val(address.locality)

      $('#state').val('').val(address.administrative_area_level_1)

      if (typeof address.street_number != 'undefined')
        streetAddress = address.street_number + ' ' + address.route
        $('#location_address1').val('').val(streetAddress)

    $('#admin-location form').on 'submit', (e) ->
      e.preventDefault()
      $.ajax
        url: $(this).attr('action')
        type: 'POST'
        dataType: 'json'
        data: $(this).serialize()
        beforeSend: ->
          $(this).find('.fa-check-circle').remove()
        success: (data)->
          if data.success
            location.reload()