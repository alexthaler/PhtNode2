define([
    'jquery',
    'underscore',
    'backbone',
    'moment',
    'howler',
    'bootstrapselect'
], ($, _, Backbone, _moment, _howler, _bootstrapselect) -> (
    gameView = Backbone.View.extend({

        el: '.game'

        events:
            "click .button.pause": "pauseGame"
            "click .button.end": "endGame"
            "change #countDirectionSelect": "countDirectionChanged"
            "change #alertSelect": "alertChanged"

        # Game data
        gameStart: ""
        gameId: ""
        gameDrinks: ""

        # Current data
        currDrink: ""

        # Options
        countDown: false
        silent: false

        startMoment: {}
        ticker: undefined
        paused: false

        alertSound: {}

        render:() ->
            @gameId = $('.gamedata').data('id')
            @gameStart = $('.gamedata').data('start')
            @gameDrinks = $('.gamedata').data('drinks')

            @pauseResumeButton = $('button.ctrl-button.pause')
            @alertSound = new Howl(
                urls: ['/audio/goodDrink.wav']
            )

            @initializeGame()
            $('.selectpicker').selectpicker();

        initializeGame: () ->
            @startMoment = moment(@gameStart)
            @currDrink = @calcDrink()
            @updateGame(@calcSec(), @currDrink)
            @tcker = setTimeout(_.bind(@tick, this), 250)

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
                clearTimeout(@ticker)
                @ticker = undefined
                @pauseResumeButton.text('Resume')
            else
                @ticker = setTimeout(_.bind(@tick, this), 250)
                @pauseResumeButton.text('Pause')

        countDirectionChanged:(e) ->
            directionId = $(e.target).find(':selected').val()
            @countDown = directionId == "down"

        alertChanged:(e) ->
            console.log('alert changed')
            console.log(e)

        tick: () ->
            sec = @calcSec()
            drink = @calcDrink()

            @updateGame(sec, drink)
            @ticker = setTimeout(_.bind(@tick, this), 250)

        updateGame: (sec, drink) ->
            if drink != @currDrink
                @currDrink = drink
                @triggerDrinkAlert()

            $('.drink-display.counter').text(" " + drink)
            $('.timer').text(@makeSecDisplay(sec))

        triggerDrinkAlert: () ->
            unless @silent
                @alertSound.play()
            else
                console.log('drink!')

        makeSecDisplay: (sec) ->
            unless @countDown
                return sec + 1
            else
                return 59 - sec

        calcDrink: () ->
            secDiff = moment().diff(@startMoment, 'seconds')
            return Math.floor((secDiff+1)/60)

        calcSec: () ->
            secDiff = moment().diff(@startMoment, 'seconds')
            return (secDiff % 60)

    });

    return gameView
));