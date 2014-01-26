(function() {
  requirejs.config({
    shim: {
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['underscore', 'jquery', 'json2'],
        exports: 'Backbone'
      },
      json2: {
        exports: 'JSON'
      },
      bootstrap: {
        deps: ['jquery']
      }
    },
    paths: {
      app: '/js/app',
      backbone: '/js/lib/backbone-min',
      jquery: '/js/lib/jquery-1.11.0.min',
      json2: '/js/lib/json2',
      underscore: '/js/lib/underscore-min',
      bootstrap: '/js/lib/bootstrap.min',
      moment: '/js/lib/moment.min'
    }
  });

}).call(this);

//# sourceMappingURL=../../public/js/config.js.map
