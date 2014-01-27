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

            @pauseResumeButton = $('.ctrl-buttons .button.pause')
            @silentAlert = $('.silent-alert')

            @initializeGame()
            @initAlertSound('good', false)
            $('.selectpicker').selectpicker();

        initializeGame: () ->
            @startMoment = moment(@gameStart)
            @currDrink = @calcDrink()
            @updateGame(@calcSec(), @currDrink)
            @tcker = setTimeout(_.bind(@tick, this), 250)

        initAlertSound:(sound, play) ->
            @alertSound = new Howl(
                urls: ['/audio/' + sound + '.wav']
            )
            if play
                @alertSound.play()

        pauseGame:(e) ->
            if @ticker
                clearTimeout(@ticker)
                @ticker = undefined
                @pauseResumeButton.text('RESUME')
                @pauseStartMoment = moment()

            else
                @startMoment.add('ms', moment().diff(@pauseStartMoment))
                @ticker = setTimeout(_.bind(@tick, this), 250)
                @pauseResumeButton.text('PAUSE')

        countDirectionChanged:(e) ->
            directionId = $(e.target).find(':selected').val()
            @countDown = directionId == "down"

        alertChanged:(e) ->
            alertId = $(e.target).find(':selected').val()
            unless alertId == "silent"
                @silent = false
                @initAlertSound(alertId, true)
            else
                @silent = true

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
                @silentAlert.fadeIn('slow', _.bind(@fadeOutSilentAlert, this))

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

        # Effects
        fadeOutSilentAlert:() ->
            @silentAlert.fadeOut('slow')

    });

    return gameView
));