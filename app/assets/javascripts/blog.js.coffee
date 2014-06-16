DemocraticTravelers.Blog =
  initialize: ->
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

  initializeComments: ->
    disqus_shortname = 'democratictravelers'
    dsq = document.createElement('script')
    dsq.type = 'text/javascript'
    dsq.async = true
    dsq.src = "//#{disqus_shortname}.disqus.com/embed.js"
    (document.getElementsByTagName('head')[0]).appendChild(dsq)

  initializeUploader: ->
    $('#post-assets').fileupload
      autoUpload: true
    .on 'fileuploaddone', (e, data) ->
      # Add hidden input to post form to associate asset with the post
      postAsset = "<input type=\"hidden\" name=\"post[asset_ids][]\" value=\"#{data.result.files[0].id}\" />"
      $('.form-post article').append(postAsset)
      $('.thumbnail').draggable
        revert: true
        revertDuration: 200
    .on 'click', '.asset-toggle-cover', (e) ->
      e.preventDefault()
      id = $(this).closest('.thumbnail').attr('data-asset-id')
      $.ajax
        url: $(this).attr('href')
        dataType: 'json'
        type: 'POST'
        success: (data) ->
          if data.success
            $(".thumbnail[data-asset-id=#{id}]").toggleClass('cover')
    .on 'click', '.asset-delete', (e) ->
      e.preventDefault()
      c = confirm 'Are you sure you want to delete this image?'
      if c == true
        id = $(this).closest('.thumbnail').attr('data-asset-id')
        $.ajax
          url: $(this).attr('href')
          dataType: 'json'
          type: 'DELETE'
          success: (data) ->
            if data.success
              $(".thumbnail[data-asset-id=#{id}]").remove()
    .on 'click', '.asset-copy-to-clipboard', (e) ->
      e.preventDefault()
      text = $(this).closest('li').attr('data-markdown')
      window.prompt("Copy to clipboard: Cmd+C, Enter", text)

    $('.add-images-btn span').click ->
      $('#asset_asset').click()

    $('.thumbnail').draggable
      revert: true
      revertDuration: 200

    $('#post_body').droppable
      accept: '.thumbnail'
      hoverClass: 'dropping'
      drop: (e, ui) ->
        text = ui.draggable[0].attributes[2].value
        $('#post_body').insertAtCaret(text)
