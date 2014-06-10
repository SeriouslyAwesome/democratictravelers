DemocraticTravelers.Suggestion =
  initialize: ->
    $('form#suggestion').on 'submit', (e) =>
      e.preventDefault()
      data = $('form#suggestion').serialize()
      @create(data)

  create: (data) ->
    # AJAX call to SuggestionsController#create
    apiKey = $('meta[name=api-key]').attr('content')
    userId = $('meta[name=user-id]').attr('content')
    
    $.ajax "#{DemocraticTravelers.API.Base}/suggestions",
      dataType: 'json'
      type: 'POST'
      data: data
      beforeSend: (xhr) ->
        xhr.setRequestHeader('X-API-KEY', apiKey)
        xhr.setRequestHeader('X-USER-ID', userId)
      success: (data, status, xhr) =>
        if data.success
          $('form#suggestion')[0].reset()
          DemocraticTravelers.Map.searchLayer.clearLayers()
          $('#new-suggestion').slideUp('fast')
          @render(data)
      error: (e) ->
        console.log(e)
        # TODO: Display apology.
      statusCode:
        401: ->
          console.log('Login is required.')
          # TODO: Display error.
        403: ->
          console.log('Not authorized.')
          # TODO: Display error.
        404: ->
          console.log('Dead link.')
          # TODO: Display error.

  render: (data) ->
    DemocraticTravelers.Map.Marker.render(data.locations[0])
    html = DemocraticTravelers.Experience.render(data.experiences[0])
    $(html).insertAfter('#new-suggestion').hide().slideDown('fast')
    if data.notice
      notice = "<div class=\"notice\">#{data.notice}</div>"
      $("[data-experience-id=#{data.experiences[0].slug}]").prepend(notice)
      $('#map-list').on 'ajax:success', '#convert', (e, data, status, xhr) ->
        $('p#suggestion-authentication').empty().html(data.greeting)
        $('#sign-up, #sign-in').remove()
        $(this).closest('.notice').slideUp('fast').html('Shazaam! You rock.')
          .slideDown('fast')
