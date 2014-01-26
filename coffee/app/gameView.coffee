define([
    'jquery',
    'underscore',
    'backbone',
    'moment'
], ($, _, Backbone, moment) -> (
    gameView = Backbone.View.extend({

        el: '.game'

        events:
            "click .button.pause": "pauseGame"
            "click .button.end": "endGame"

        startMoment: {}
        ticker: undefined
        paused: false

        render:() ->
            @.startMoment = moment($('.starttime').text())
            @.startGame()

            @gameId = $('.hidden.gameid').text()
            @pauseResumeButton = $('button.ctrl-button.pause')

        startGame:(e) ->
            unless @ticker
                @ticker = setTimeout(_.bind(@.tickGameDisplay, this), 250)
            else
                console.log 'game already started'

        endGame:(e) ->
            clearTimeout(@.ticker)
            $.ajax(
                type: "DELETE"
                url: '/api/v1/game/' + @gameId
                dataType: 'text'
                success: (data) ->
                    window.location = window.location.origin
            )

        pauseGame:(e) ->
            if @ticker
                clearTimeout(@.ticker)
                @ticker = undefined
                @pauseResumeButton.text('Resume')
            else
                @ticker = setTimeout(_.bind(@.tickGameDisplay, this), 250)
                @pauseResumeButton.text('Pause')

        tickGameDisplay: () ->
            secDiff = moment().diff(@startMoment, 'seconds')
            displaySec = (secDiff % 60) + 1

            minDiff = Math.floor(secDiff/60)
            $('.drink-display.counter').text(" " + minDiff)

            $('.timer').text(displaySec)
            @.ticker = setTimeout(_.bind(@.tickGameDisplay, this), 250)

    });

    return gameView
));