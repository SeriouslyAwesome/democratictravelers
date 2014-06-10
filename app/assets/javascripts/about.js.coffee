jQuery ->
  baseline = 28

  $('#family').each ->
    $(this).waitForImages -> 
      $(this).find('img').baseline(baseline)

  $('#press').waitForImages -> 
    $(this).find('img').baseline(baseline)