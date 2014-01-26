require(['jquery', 'backbone', 'app/gameView'],
    ($, Backbone, GameView) ->
        $(document).ready(() ->
            view = new GameView()
            view.render()
        )
)