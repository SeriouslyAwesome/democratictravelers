(function() {
  DemocraticTravelers.Map = {
    Router: new Router(),
    Search: {},
    Marker: {},
    Auth: {},
    CurrentLocation: {},
    Suggestions: {},
    mapObject: null,
    searchLayer: null,
    locationsLayer: null,
    markers: [],

    init: function() {
      // Initialize Map
      this.mapObject = L.mapbox.map('map', 'seriouslyawesome.i675cgi9', {
        center: [37.09024, -95.71289100000001],
        zoom: 4,
        minZoom: 4,
        maxZoom: 12
      });

      var offset = this.mapObject.getSize().x * 0.15;
      this.mapObject.panBy(new L.Point(offset, 0), { animate: false });
      this.mapObject.zoomControl.setPosition('bottomleft');

      // Initialize Markers
      this.locationsLayer = L.layerGroup().addTo(this.mapObject);
      this.CurrentLocation.init(this.mapObject);
      this.Suggestions.initialize();
      this.Suggestions.fetch();
      this.Search.initialize(this.mapObject);
      this.Auth.initialize();

      // Setup Map/List view toggler
      this.initDragFiltering();
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

    initDragFiltering: function() {
      var self = this;
      this.mapObject.on('moveend', function() {
        DemocraticTravelers.Map.Experiences.filterList();
      });
    }
  };
})();
