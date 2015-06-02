jQuery ->
  if $('#instagrams').length
    fetchInstagrams(6)

fetchInstagrams = (limit) ->

  # Empty array that we'll dump both Instagram accounts into
  joinedFeeds = []

  johnsFeed = new Instafeed
    get: 'user'
    target: 'johns-instagram'
    userId: 22507641
    accessToken: '22507641.467ede5.aee7c6831bb04d89861cacde92bc6501'
    mock: true
    limit: limit
    success: (data) ->
      # Push John's images to the array
      for image in data.data
        joinedFeeds.push(image)

      # Once John's feed is done, load Laura's
      laurasFeed.run()

  laurasFeed = new Instafeed
    get: 'user'
    target: 'lauras-instagram'
    userId: 1263166
    accessToken: '1263166.467ede5.f736c9c40afe44abbeff856d4f27ea18'
    mock: true
    limit: limit
    success: (data) ->
      # Push Laura's images to the array
      for image in data.data
        joinedFeeds.push(image)

      # Sort all of the images by date/time
      joinedFeeds.sort (a, b) ->
        return b.created_time - a.created_time

      thumbnails = ""

      # Create HTML strings out of the JSON and join them into one long string
      $.each joinedFeeds, (i, obj) ->
        caption = ''
        caption = obj.caption.text if obj.caption
        thumbnails += "<a href='#{obj.link}' class='social' alt='View on Instagram' target='_blank'><img src='#{obj.images.low_resolution.url}' title='#{caption}' style='display:none;'></a>"

      # Append the HTML string to the document
      $("#instagrams").html(thumbnails)

      # Wait for each one to load and then fade it in.
      $("#instagrams img").each ->
        $(this).load ->
          $(this).fadeIn('fast');

  #Start the whole process.
  johnsFeed.run()
