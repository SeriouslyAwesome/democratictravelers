DemocraticTravelers.Experience =
  
  done: (id) ->
    # AJAX /experiences/:id/done

  render: (experience) ->
    HandlebarsTemplates['experience'](experience)

  renderAll: (experiences) ->
    html = ''
    for experience in experiences
      html += @render experience

    $('#map-list').append(html)

    # Cache the jQuery selection of list items for later filtering performance
    DemocraticTravelers.Map.experienceList = $('#map-list')
      .find('.suggestion').not('#new-suggestion')

    $('#map-list').on 'click', 'button.upvote', (e) ->
      id = $(this).data('id')
      endpoint = "experiences/#{id}/upvote"
      DemocraticTravelers.API.vote(this, endpoint)

    $('#map-list').on 'click', 'button.downvote', (e) ->
      id = $(this).data('id')
      endpoint = "experiences/#{id}/downvote"
      DemocraticTravelers.API.vote(this, endpoint)
      
    