(function() {
  window.DemocraticTravelers = window.DemocraticTravelers || {};

  DemocraticTravelers.Templates = DemocraticTravelers.Templates || {};

  DemocraticTravelers.Templates.experiences = function(data) {
    var html = '';
    var experiences = data.experiences || [];
    for (var i = 0; i < experiences.length; i++) {
      html += DemocraticTravelers.Templates.experience(experiences[i]);
    }
    return html;
  };
})();
