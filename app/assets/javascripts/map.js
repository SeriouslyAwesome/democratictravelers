(function() {
  DemocraticTravelers.Map = {
    Router: new Router(),
    Search: {},
    Marker: {},
    Auth: {},
    CurrentLocation: {},
    Suggestions: {},
    mapObject: null,
    searchMarker: null,
    markers: [],

    init: function() {
      var token = $('#map').data('mapbox-token');

      // Initialize Map (requires WebGL)
      if (typeof mapboxgl !== 'undefined' && mapboxgl.supported()) {
        mapboxgl.accessToken = token;

        this.mapObject = new mapboxgl.Map({
          container: 'map',
          style: 'mapbox://styles/mapbox/dark-v11',
          center: [-95.71289, 37.09024],
          zoom: 4,
          minZoom: 4,
          maxZoom: 12
        });

        var self = this;
        this.mapObject.on('load', function() {
          var offset = self.mapObject.getContainer().offsetWidth * 0.15;
          self.mapObject.panBy([offset, 0], { animate: false });
        });

        this.mapObject.addControl(new mapboxgl.NavigationControl(), 'bottom-left');

        // Initialize Markers
        this.CurrentLocation.init(this.mapObject);
        this.Search.initialize(this.mapObject);
        this.initDragFiltering();
      }

      this.Suggestions.initialize();
      this.Suggestions.fetch();
      this.Auth.initialize();

      // Setup Map/List view toggler
      $('#show-map, #show-list').click(function() {
        DemocraticTravelers.Map.toggleView(this);
      });

      $('#map-list').on('click', '.map-user-link', function(e) {
        e.preventDefault();
        DemocraticTravelers.Map.Router.navigate($(this).attr('href'), $(this).html() + "'s Suggestions | The Democratic Travelers");
      });
    },

    toggleView: function(button) {
      $(button).hide();
      $(button).siblings().show();
      $('#map-list').slideToggle('fast');
    },

    toggleForm: function() {
      $('#new-suggestion').slideToggle('fast').reset();
    },

    renderMarkers: function(locations) {
      for (var i = 0; i < locations.length; i++) {
        this.Marker.render(locations[i]);
      }
    },

    clearMarkers: function() {
      for (var i = 0; i < this.markers.length; i++) {
        this.markers[i].remove();
      }
      this.markers = [];
    },

    clearSearchMarker: function() {
      if (this.searchMarker) {
        this.searchMarker.remove();
        this.searchMarker = null;
      }
    },

    initDragFiltering: function() {
      var self = this;
      this.mapObject.on('moveend', function() {
        DemocraticTravelers.Map.Experiences.filterList();
      });
    }
  };
})();
