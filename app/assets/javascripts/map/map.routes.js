(function() {
  var dtr = DemocraticTravelers.Map.Router;
  var api = DemocraticTravelers.API;

  dtr.route('/map', function() {
    DemocraticTravelers.Map.Experiences.filterList();
  });

  dtr.route('/map/ambassadors/:id', function(id) {
    id = id.split('?')[0];
    DemocraticTravelers.Map.Experiences.filterList(`[data-user-id="${id}"]`);
  });

  dtr.route('/map/locations/:id', function(id) {
    id = id.split('?')[0];
    DemocraticTravelers.Map.Experiences
      .filterList(`[data-location-id="${id}"]`);
    var markers = DemocraticTravelers.Map.markers;
    for (var i = 0; i < markers.length; i++) {
      if (markers[i]._locationId == parseInt(id)) {
        markers[i].togglePopup();
        break;
      }
    }
  });

  dtr.route('/map/:id', function(id) {
    id = id.split('?')[0];
    DemocraticTravelers.Map.Experiences
      .filterList(`[data-experience-id="${id}"]`);
    var locationId = $(`.suggestion[data-experience-id="${id}"]`).data('location-id');
    var markers = DemocraticTravelers.Map.markers;
    for (var i = 0; i < markers.length; i++) {
      if (markers[i]._locationId == parseInt(locationId)) {
        markers[i].togglePopup();
        break;
      }
    }
  });
})();
