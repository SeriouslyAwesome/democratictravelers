(function() {
  $(document).ready(function() {
    if ($('#instagrams').length) {
      fetchInstagrams(8);
    }
  });

  var fetchInstagrams = function(limit) {
    var joinedFeeds = [];

    var johnsFeed = new Instafeed({
      get: 'user',
      target: 'johns-instagram',
      userId: 22507641,
      accessToken: '22507641.467ede5.aee7c6831bb04d89861cacde92bc6501',
      mock: true,
      limit: limit,
      success: function(data) {
        for (var i = 0; i < data.data.length; i++) {
          joinedFeeds.push(data.data[i]);
        }
        laurasFeed.run();
      }
    });

    var laurasFeed = new Instafeed({
      get: 'user',
      target: 'lauras-instagram',
      userId: 1263166,
      accessToken: '1263166.467ede5.f736c9c40afe44abbeff856d4f27ea18',
      mock: true,
      limit: limit,
      success: function(data) {
        for (var i = 0; i < data.data.length; i++) {
          joinedFeeds.push(data.data[i]);
        }

        joinedFeeds.sort(function(a, b) {
          return b.created_time - a.created_time;
        });

        var thumbnails = "";

        $.each(joinedFeeds, function(i, obj) {
          var caption = '';
          if (obj.caption) {
            caption = obj.caption.text;
          }
          thumbnails += `<a href='${obj.link}' class='social instagram' style='background-image: url(${obj.images.standard_resolution.url});' target='_blank'>${caption}</a>`;
        });

        $("#instagrams").html(thumbnails);

        $("#instagrams a").each(function() {
          $(this).fadeIn('fast');
        });
      }
    });

    johnsFeed.run();
  };
})();
