(function() {
  DemocraticTravelers.Map.Marker = {
    render: function(location) {
      if (!DemocraticTravelers.Map.mapObject) return;

      var loc = location.properties;
      var className;
      if (loc.done == true) {
        className = 'map-pin map-pin-done';
      } else {
        className = 'map-pin';
      }

      var el = document.createElement('div');
      el.className = className;
      el.innerHTML = '<span>' + loc.votes + '</span>';

      var popupContent = '<h4>' + loc.name + '<br><small>' + loc.city + ', ' + loc.state + '</small></h4>';
      var titleContent = 'What to do at ' + loc.name + ' in ' + loc.city + ', ' + loc.state + ' | The Democratic Travelers';

      var popup = new mapboxgl.Popup({ offset: [0, -46] })
        .setHTML(popupContent);

      var marker = new mapboxgl.Marker({ element: el, anchor: 'bottom' })
        .setLngLat(location.geometry.coordinates)
        .setPopup(popup)
        .addTo(DemocraticTravelers.Map.mapObject);

      marker._locationId = loc.id;
      DemocraticTravelers.Map.markers.push(marker);

      el.addEventListener('click', function() {
        marker.togglePopup();
        DemocraticTravelers.Map.Router.navigate('/map/locations/' + loc.id, titleContent);
      });

      popup.on('close', function() {
        DemocraticTravelers.Map.Router.navigate("/map", "The Map | The Democratic Travelers");
        DemocraticTravelers.Map.Experiences.filterList();
      });
    }
  };
})();
