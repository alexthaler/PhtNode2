(function() {
  define(['jquery', 'underscore', 'backbone', 'moment'], function($, _, Backbone, moment) {
    var gameView;
    gameView = Backbone.View.extend({
      el: '.game',
      events: {
        "click .button.pause": "pauseGame",
        "click .button.end": "endGame"
      },
      startMoment: {},
      ticker: void 0,
      paused: false,
      render: function() {
        this.startMoment = moment($('.starttime').text());
        this.startGame();
        this.gameId = $('.hidden.gameid').text();
        return this.pauseResumeButton = $('button.ctrl-button.pause');
      },
      startGame: function(e) {
        if (!this.ticker) {
          return this.ticker = setTimeout(_.bind(this.tickGameDisplay, this), 250);
        } else {
          return console.log('game already started');
        }
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
          this.ticker = setTimeout(_.bind(this.tickGameDisplay, this), 250);
          return this.pauseResumeButton.text('Pause');
        }
      },
      tickGameDisplay: function() {
        var displaySec, minDiff, secDiff;
        secDiff = moment().diff(this.startMoment, 'seconds');
        displaySec = (secDiff % 60) + 1;
        minDiff = Math.floor(secDiff / 60);
        $('.drink-display.counter').text(" " + minDiff);
        $('.timer').text(displaySec);
        return this.ticker = setTimeout(_.bind(this.tickGameDisplay, this), 250);
      }
    });
    return gameView;
  });

}).call(this);

//# sourceMappingURL=../../../public/js/app/gameView.js.map
