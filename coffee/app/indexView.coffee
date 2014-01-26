define([
    'jquery',
    'underscore',
    'backbone'
], ($, _, Backbone) -> (
    indexView = Backbone.View.extend({

        el: '.create'

        events:
            "click .submit": "submit_game"

        render:() ->
            console.log 'yay rendering!'
            console.log this.$el

        submit_game:(e) ->
            game_name = @$('.name').val()
            game_drinks = @$('.drinks').val()
            $.ajax(
                type: "POST"
                url: '/api/v1/game/' + game_name + '/' + game_drinks
                dataType: 'json'
                success: (data, textStats, jqXHR) ->
                    window.location = window.location.origin + '/game/' + data.id
            )

    });

    return indexView
));