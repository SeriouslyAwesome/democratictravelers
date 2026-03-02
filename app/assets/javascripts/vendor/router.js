(function() {
  /*
  Copyright (C) <2012> <haithem bel haj>
  (MIT License text)
  Updated to use native History API instead of History.js
  */
  window.Router = function(routes) {
    this.routes = routes || {};
    this.trigger = true;

    var self = this;
    window.addEventListener('popstate', function() {
      self.checkRoutes({
        data: {},
        url: window.location.pathname
      });
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
        var url = state.url || state.data.url || window.location.pathname;
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
    if (title) { document.title = title; }
    if (replace) {
      window.history.replaceState(data, title, url);
    } else {
      window.history.pushState(data, title, url);
    }
    if (this.trigger) {
      this.checkRoutes({ data: data, url: url });
    }
    this.trigger = true;
  };

  Router.prototype.start = function(url) {
    url = url || window.location.pathname;
    return this.checkRoutes({ data: {}, url: url });
  };

  Router.prototype.go = function(num) {
    window.history.go(num);
  };

  Router.prototype.back = function() {
    window.history.back();
  };
})();
