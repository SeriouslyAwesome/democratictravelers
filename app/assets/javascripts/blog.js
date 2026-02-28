(function() {
  DemocraticTravelers.Blog = {
    initialize: function() {
      var baseline = 28;

      $('.caption').each(function() {
        $(this).waitForImages(function() {
          $(this).baseline(baseline);
        });
      });

      $('.post-mini-preview').each(function() {
        $(this).waitForImages(function() {
          $(this).find('img').baseline(baseline);
        });
      });

      if ($('body.posts.show').length) {
        DemocraticTravelers.Blog.initializeComments();
      }

      if ($('#post-assets').length) {
        DemocraticTravelers.Blog.initializeUploader();
      }
    },

    initializeComments: function() {
      var disqus_shortname = 'democratictravelers';
      var dsq = document.createElement('script');
      dsq.type = 'text/javascript';
      dsq.async = true;
      dsq.src = `//${disqus_shortname}.disqus.com/embed.js`;
      (document.getElementsByTagName('head')[0]).appendChild(dsq);
    },

    initializeUploader: function() {
      $('#post-assets').fileupload({
        autoUpload: true,
        dataType: 'json'
      })
      .on('fileuploaddone', function(e, data) {
        var postAsset = `<input type="hidden" name="post[asset_ids][]" value="${data.result.files[0].id}" />`;
        $('.form-post article').append(postAsset);
        $('.thumbnail').draggable({
          revert: true,
          revertDuration: 200
        });
      })
      .on('click', '.asset-toggle-cover', function(e) {
        e.preventDefault();
        var id = $(this).closest('.thumbnail').attr('data-asset-id');
        $.ajax({
          url: $(this).attr('href'),
          dataType: 'json',
          type: 'POST',
          success: function(data) {
            if (data.success) {
              $(`.thumbnail[data-asset-id=${id}]`).toggleClass('cover');
            }
          }
        });
      })
      .on('click', '.asset-delete', function(e) {
        e.preventDefault();
        var c = confirm('Are you sure you want to delete this image?');
        if (c == true) {
          var id = $(this).closest('.thumbnail').attr('data-asset-id');
          $.ajax({
            url: $(this).attr('href'),
            dataType: 'json',
            type: 'DELETE',
            success: function(data) {
              if (data.success) {
                $(`.thumbnail[data-asset-id=${id}]`).remove();
                $(`#post-asset-id-${id}`).remove();
              }
            }
          });
        }
      })
      .on('click', '.asset-copy-to-clipboard', function(e) {
        e.preventDefault();
        var text = $(this).closest('li').attr('data-markdown');
        window.prompt("Copy to clipboard: Cmd+C, Enter", text);
      });

      $('.add-images-btn span').click(function() {
        $('#asset_asset').click();
      });

      $('.thumbnail').draggable({
        revert: true,
        revertDuration: 200
      });

      $('#post_body').droppable({
        accept: '.thumbnail',
        hoverClass: 'dropping',
        drop: function(e, ui) {
          var text = ui.draggable[0].attributes[2].value;
          $('#post_body').insertAtCaret(text);
        }
      });
    }
  };
})();
