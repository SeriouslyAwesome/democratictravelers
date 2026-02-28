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
    DemocraticTravelers.Map.locationsLayer.eachLayer(function(marker) {
      if (marker.options.id == parseInt(id)) {
        marker.openPopup();
        return false;
      }
    });
  });

  dtr.route('/map/:id', function(id) {
    id = id.split('?')[0];
    DemocraticTravelers.Map.Experiences
      .filterList(`[data-experience-id="${id}"]`);
    var locationId = $(`.suggestion[data-experience-id="${id}"]`).data('location-id');
    DemocraticTravelers.Map.locationsLayer.eachLayer(function(marker) {
      if (marker.options.id == parseInt(locationId)) {
        marker.openPopup();
        return false;
      }
    });
  });
})();
