game_service = require('../services/game_service')

home = (req, res) ->
    games = game_service.getAll((games) =>
        res.render("home", {games: games})
    )

game = (req, res) ->
    id = req.params.id
    game = game_service.get(id, (game) =>
        res.render("game", {game: game})
    )

exports.home = home
exports.game = game