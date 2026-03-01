(function() {
  /*
  Copyright (C) <2012> <haithem bel haj>
  (MIT License text)
  */
  window.Router = function(routes) {
    this.routes = routes || {};
    this.trigger = true;

    var self = this;
    History.Adapter.bind(window, 'statechange', () => {
      self.checkRoutes(History.getState());
    });
  };

  Router.namedParam = /:\w+/g;
  Router.splatParam = /\*\w+/g;

  Router.prototype.route = function(route, callback) {
    route = route.replace(Router.namedParam, '([^\\/]+)')
      .replace(Router.splatParam, '(.*?)');
    this.routes[`^${route}$`] = callback;
  };

  Router.prototype.checkRoutes = function(state) {
    if (this.trigger) {
      for (var regexText in this.routes) {
        var callback = this.routes[regexText];
        var regex = new RegExp(regexText);
        var url = state.data.url || state.hash;
        if (regex.test(url)) {
          callback.apply(window, regex.exec(url).slice(1));
        }
      }
    }
    this.trigger = true;
  };

  Router.prototype.navigate = function(url, title, data, trigger, replace) {
    if (typeof trigger === 'undefined') { trigger = true; }
    if (typeof replace === 'undefined') { replace = true; }
    data = data || {};
    this.trigger = trigger;
    if (replace) {
      History.replaceState(data, title, url);
    } else {
      History.pushState(data, title, url);
    }
  };

  Router.prototype.start = function(url) {
    url = url || window.location.pathname;
    return this.checkRoutes(History.getState(url));
  };

  Router.prototype.go = function(num) {
    History.go(num);
  };

  Router.prototype.back = function() {
    History.back();
  };
})();
