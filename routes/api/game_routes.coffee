game_service = require('../../services/game_service')

create = (req, res) ->
    game_name = req.params.name
    game_drinks = req.params.drinks

    game = game_service.create(game_name, game_drinks)

    res.json(game)

get = (req, res) ->
    id = req.params.id

    game_service.get(id, (game) =>
        res.json(game)
    )

list = (req, res) ->
    game_service.getAll((games) =>
        res.json(games)
    )

remove = (req, res) ->
    id = req.params.id

    game_service.remove(id, () ->
        res.send(200)
    )

exports.create = create
exports.get = get
exports.list = list
exports.remove = remove