jQuery ->
  baseline = 28

  $('.caption').each ->
    $(this).waitForImages -> 
      $(this).baseline(baseline)

  $('.post-mini-preview').each ->
    $(this).waitForImages -> 
      $(this).find('img').baseline(baseline)

  # Add Disqus
  if $('body.posts.show').length
    DemocraticTravelers.Blog.initializeComments()

  # Initialize File Uploads
  if $('#post-assets').length
    DemocraticTravelers.Blog.initializeUploader()
    