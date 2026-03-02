(function() {
  DemocraticTravelers.Map.Suggestions = {
    initialize: function() {
      var self = this;
      $('form#suggestion').on('submit', function(e) {
        e.preventDefault();
        var data = $('form#suggestion').serialize();
        self.create(data);
      });
    },

    fetch: function() {
      var url = "/api/v1/suggestions/";
      var apiKey = $("meta[name='application-name']").attr('data-api-key');
      var userId = $("meta[name='application-name']").attr('data-user-id');

      $.ajax(url, {
        dataType: 'json',
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-API-KEY', apiKey);
          xhr.setRequestHeader('X-USER-ID', userId);
          DemocraticTravelers.Map.clearMarkers();
          $('.suggestion').not('#new-suggestion').remove();
          $('#map-loading:hidden').fadeIn('fast');
        },
        success: function(data, callback) {
          DemocraticTravelers.Map.renderMarkers(data.locations);
          DemocraticTravelers.Map.Experiences.renderAll(data);
        },
        error: function(e) {
          console.log(e);
          return true;
        },
        complete: function() {
          $('#map-loading:visible').fadeOut('fast');
        },
        statusCode: {
          401: function() { console.log('Login is required.'); },
          403: function() { console.log('Not authorized.'); },
          404: function() { console.log('Dead link.'); }
        }
      });
    },

    create: function(data) {
      var self = this;
      var url = "/api/v1/suggestions/";
      var apiKey = $("meta[name='application-name']").attr('data-api-key');
      var userId = $("meta[name='application-name']").attr('data-user-id');

      $.ajax(url, {
        dataType: 'json',
        type: 'POST',
        data: data,
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-API-KEY', apiKey);
          xhr.setRequestHeader('X-USER-ID', userId);
        },
        success: function(data, status, xhr) {
          if (data.success) {
            $('form#suggestion')[0].reset();
            DemocraticTravelers.Map.clearSearchMarker();
            $('#new-suggestion').slideUp('fast');
            self.render(data);

            // Google Analytics
            var exp = data.experiences[0];
            var label = exp.name + ' at ' + exp.venue + ' in ' + exp.city + ', ' + exp.state;
            ga('send', 'event', 'Suggestion', 'Submit', label);
          }
        },
        error: function(e) {
          console.log(e);
        },
        statusCode: {
          401: function() { console.log('Login is required.'); },
          403: function() { console.log('Not authorized.'); },
          404: function() { console.log('Dead link.'); }
        }
      });
    },

    render: function(data) {
      DemocraticTravelers.Map.Marker.render(data.locations[0]);
      var html = DemocraticTravelers.Map.Experiences.render(data.experiences[0]);
      $(html).insertAfter('#new-suggestion').hide().slideDown('fast');
      if (data.notice) {
        var notice = '<div class="notice">' + data.notice + '</div>';
        $('[data-experience-id=' + data.experiences[0].slug + ']').prepend(notice);
        $('#map-list').on('ajax:success', '#convert', function(e, data, status, xhr) {
          $('p#suggestion-authentication').empty().html(data.greeting);
          $('#sign-up, #sign-in').remove();
          $(this).closest('.notice').slideUp('fast').html('Shazaam! You rock.').slideDown('fast');
        });
      }
    }
  };
})();
