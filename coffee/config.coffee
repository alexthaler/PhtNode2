requirejs.config(
    shim:
        underscore:
            exports:'_'
        backbone:
            deps: ['underscore', 'jquery', 'json2']
            exports: 'Backbone'
        json2:
            exports: 'JSON'
        bootstrap:
            deps: ['jquery']
        jquerydropdown:
            deps: ['jquery']
        socketio:
            exports: 'io'

    paths:
        app: '/js/app'
        backbone: '/js/lib/backbone-min'
        jquery: '/js/lib/jquery-1.11.0.min'
        jquerydropdown: '/js/lib/jquery.dropdown'
        json2: '/js/lib/json2'
        underscore: '/js/lib/underscore-min'
        bootstrap: '/js/lib/bootstrap.min'
        bootstrapselect: '/js/lib/bootstrap-select.min'
        moment: '/js/lib/moment.min'
        howler: '/js/lib/howler.min'
        socketio: '../socket.io/socket.io'
)