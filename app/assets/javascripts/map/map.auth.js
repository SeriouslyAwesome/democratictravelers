(function() {
  function getEventDetail(e) {
    if (e.detail) return e.detail;
    if (e.originalEvent && e.originalEvent.detail) return e.originalEvent.detail;
    return [];
  }

  DemocraticTravelers.Map.Auth = {
    initialize: function() {
      $('#new-suggestion, #sign-in, #sign-up').hide();

      var signInForm = $('form#sign-in');

      signInForm.on('ajax:success', function(e) {
        var detail = getEventDetail(e);
        var data = detail[0];
        if (data.success) {
          $("meta[name='application-name']").attr('data-api-key', data.api_key);
          $("meta[name='application-name']").attr('data-user-id', data.user_id);
          $('p#suggestion-authentication').empty().html(data.greeting);
          $(this).slideUp('fast', function() {
            $('#sign-up, #sign-in').remove();
          });
        } else {
          $(this).find('label').first()
            .before('<p class="error">' + data.errors + '</p>');
          $(this).find('p.error').hide().slideToggle('fast');
        }
      });

      signInForm.on('ajax:error', function(e) {
        var detail = getEventDetail(e);
        var xhr = detail[2];
        try {
          var responseJSON = JSON.parse(xhr.responseText);
          $(this).find('label:first-child')
            .before('<p class="error">' + responseJSON.errors[0] + '</p>');
        } catch(err) {
          $(this).find('label:first-child')
            .before('<p class="error">Sign in failed. Please try again.</p>');
        }
      });

      var signUpForm = $('form#sign-up');

      signUpForm.on('ajax:success', function(e) {
        var detail = getEventDetail(e);
        var data = detail[0];
        if (data.success) {
          $("meta[name='application-name']").attr('data-api-key', data.api_key);
          $("meta[name='application-name']").attr('data-user-id', data.user_id);
          $('p#suggestion-authentication').empty().html(data.greeting);
          $(this).slideUp('fast', function() {
            $('#sign-up, #sign-in').remove();
          });
        } else {
          $(this).find('label').first()
            .before('<p class="error">' + data.errors + '</p>');
          $(this).find('p.error').hide().slideToggle('fast');
        }
      });

      signUpForm.on('ajax:error', function(e) {
        var detail = getEventDetail(e);
        var xhr = detail[2];
        try {
          var responseJSON = JSON.parse(xhr.responseText);
          $(this).find('label:first-child')
            .before('<p class="error">' + responseJSON.errors[0] + '</p>');
        } catch(err) {
          $(this).find('label:first-child')
            .before('<p class="error">Sign up failed. Please try again.</p>');
        }
      });
    }
  };
})();
