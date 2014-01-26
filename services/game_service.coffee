uuid = require('node-uuid')
redis = require('redis')
_ = require('underscore')

game_prefix = "GAME_"
game_ttl = 4000

create = (name, drinks) -> (
    client = redis.createClient()

    game_id = uuid.v4()
    game_key = game_prefix + game_id
    console.log('game id ' + game_id)

    game =
        id: game_id
        name: name
        drinks: drinks
        start: new Date().toISOString()

    game_json = JSON.stringify(game)

    client.set(game_key, game_json, redis.print)
    client.expire(game_id, game_ttl, redis.print)
    client.quit()

    return game
)

get = (id, callback) -> (
    client = redis.createClient()
    game = {}

    client.get(game_prefix + id, (err, resp) =>
        client.quit()
        game = JSON.parse(resp)
        callback(game)
    )
)

getAll = (callback) -> (
    client = redis.createClient()
    games = []

    client.keys(game_prefix + "*", (err, resp) =>
        unless err
            client.mget(resp, (err, resp) =>
                client.quit()
                games = _.map(resp, (json) -> (JSON.parse(json)))
                callback(games)
            )
    )
)

remove = (id, callback) -> (
    client = redis.createClient()

    client.del(game_prefix + id, (err, resp) =>
        unless err
            callback()
    )
)

exports.create = create
exports.get = get
exports.getAll = getAll
exports.remove = remove
