(function() {
  define(['jquery', 'underscore', 'backbone', 'moment', 'howler', 'bootstrapselect'], function($, _, Backbone, _moment, _howler, _bootstrapselect) {
    var gameView;
    gameView = Backbone.View.extend({
      el: '.game',
      events: {
        "click .button.pause": "pauseGame",
        "click .button.end": "endGame",
        "change #countDirectionSelect": "countDirectionChanged",
        "change #alertSelect": "alertChanged"
      },
      gameStart: "",
      gameId: "",
      gameDrinks: "",
      currDrink: "",
      countDown: false,
      silent: false,
      startMoment: {},
      ticker: void 0,
      paused: false,
      alertSound: {},
      render: function() {
        this.gameId = $('.gamedata').data('id');
        this.gameStart = $('.gamedata').data('start');
        this.gameDrinks = $('.gamedata').data('drinks');
        this.pauseResumeButton = $('button.ctrl-button.pause');
        this.initializeGame();
        this.initAlertSound('good');
        return $('.selectpicker').selectpicker();
      },
      initializeGame: function() {
        this.startMoment = moment(this.gameStart);
        this.currDrink = this.calcDrink();
        this.updateGame(this.calcSec(), this.currDrink);
        return this.tcker = setTimeout(_.bind(this.tick, this), 250);
      },
      initAlertSound: function(sound) {
        return this.alertSound = new Howl({
          urls: ['/audio/' + sound + '.wav']
        });
      },
      endGame: function(e) {
        clearTimeout(this.ticker);
        return $.ajax({
          type: "DELETE",
          url: '/api/v1/game/' + this.gameId,
          dataType: 'text',
          success: function(data) {
            return window.location = window.location.origin;
          }
        });
      },
      pauseGame: function(e) {
        if (this.ticker) {
          clearTimeout(this.ticker);
          this.ticker = void 0;
          return this.pauseResumeButton.text('Resume');
        } else {
          this.ticker = setTimeout(_.bind(this.tick, this), 250);
          return this.pauseResumeButton.text('Pause');
        }
      },
      countDirectionChanged: function(e) {
        var directionId;
        directionId = $(e.target).find(':selected').val();
        return this.countDown = directionId === "down";
      },
      alertChanged: function(e) {
        var alertId;
        alertId = $(e.target).find(':selected').val();
        if (alertId !== "silent") {
          this.silent = false;
          return this.initAlertSound(alertId);
        } else {
          return this.silent = true;
        }
      },
      tick: function() {
        var drink, sec;
        sec = this.calcSec();
        drink = this.calcDrink();
        this.updateGame(sec, drink);
        return this.ticker = setTimeout(_.bind(this.tick, this), 250);
      },
      updateGame: function(sec, drink) {
        if (drink !== this.currDrink) {
          this.currDrink = drink;
          this.triggerDrinkAlert();
        }
        $('.drink-display.counter').text(" " + drink);
        return $('.timer').text(this.makeSecDisplay(sec));
      },
      triggerDrinkAlert: function() {
        if (!this.silent) {
          return this.alertSound.play();
        } else {
          return console.log('drink!');
        }
      },
      makeSecDisplay: function(sec) {
        if (!this.countDown) {
          return sec + 1;
        } else {
          return 59 - sec;
        }
      },
      calcDrink: function() {
        var secDiff;
        secDiff = moment().diff(this.startMoment, 'seconds');
        return Math.floor((secDiff + 1) / 60);
      },
      calcSec: function() {
        var secDiff;
        secDiff = moment().diff(this.startMoment, 'seconds');
        return secDiff % 60;
      }
    });
    return gameView;
  });

}).call(this);

//# sourceMappingURL=../../../public/js/app/gameView.js.map
