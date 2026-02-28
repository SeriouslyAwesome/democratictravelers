(function() {
  DemocraticTravelers.Map.Auth = {
    initialize: function() {
      $('#new-suggestion, #sign-in, #sign-up').hide();

      var signInForm = $('form#sign-in');

      signInForm.on('ajax:success', function(e, data, status, xhr) {
        if (data.success) {
          $("meta[name='application-name']").attr('data-api-key', data.api_key);
          $("meta[name='application-name']").attr('data-user-id', data.user_id);
          $('p#suggestion-authentication').empty().html(data.greeting);
          $(this).slideUp('fast', function() {
            $('#sign-up, #sign-in').remove();
          });
          ga('send', 'event', 'User', 'Sign In', {'nonInteraction': 1});
        } else {
          $(this).find('label').first()
            .before(`<p class="error">${data.errors}</p>`);
          $(this).find('p.error').hide().slideToggle('fast');
        }
      });

      signInForm.on('ajax:error', function(xhr, status, error) {
        $(this).find('label:first-child')
          .before(`<p class="error">${status.responseJSON.errors[0]}</p>`);
      });

      var signUpForm = $('form#sign-up');

      signUpForm.on('ajax:success', function(e, data, status, xhr) {
        if (data.success) {
          $("meta[name='application-name']").attr('data-api-key', data.api_key);
          $("meta[name='application-name']").attr('data-user-id', data.user_id);
          $('p#suggestion-authentication').empty().html(data.greeting);
          $(this).slideUp('fast', function() {
            $('#sign-up, #sign-in').remove();
          });
          ga('send', 'event', 'User', 'Sign Up', {'nonInteraction': 1});
        } else {
          $(this).find('label').first()
            .before(`<p class="error">${data.errors}</p>`);
          $(this).find('p.error').hide().slideToggle('fast');
        }
      });

      signUpForm.on('ajax:error', function(xhr, status, error) {
        $(this).find('label:first-child')
          .before(`<p class="error">${status.responseJSON.errors[0]}</p>`);
      });
    }
  };
})();
