express = require('express')
_ = require('underscore')

routes = require('./routes')

app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)

app.use(app.router)
app.use(express.static('public'));
app.use(express.bodyParser());
app.use(express.errorHandler());

app.set('view engine', 'jade');

app.get("/", routes.home.home)
app.get("/game/:id", routes.home.game)

app.get("/api/v1/game", routes.api.game_routes.list)
app.get("/api/v1/game/:id", routes.api.game_routes.get)
app.post("/api/v1/game/:name/:drinks", routes.api.game_routes.create)
app.delete("/api/v1/game/:id", routes.api.game_routes.remove)

server.listen(3000)

allSockets = []

socketIdGameIdMap = {}
gameParticipants = {}

io.sockets.on('connection', (socket) ->
    console.log 'connected client ' + socket
    console.log 'socketId :' + socket.id
    allSockets.push(socket)

    socket.on('join', (game) ->
        console.log 'socket joined game!'
        gameId = game.id

        socketIdGameIdMap[socket.id] = game.id

        if gameParticipants[gameId] == undefined
            gameParticipants[gameId] = [socket]
        else
            gameParticipants[gameId].push(socket)

    )

    socket.on('pause', (game) ->
        console.log 'socket pausing game ' + game.id
        gameId = game.id

        participants = gameParticipants[gameId]
        console.log("num participants: " + participants.length)

        _.each(participants, (socket) =>
            console.log 'firiing for socket ' + socket.id
            socket.emit('pause', {id: @gameId})
        )
    )

    socket.on('resume', (game) ->
        console.log 'socket resuming game ' + game.id
        gameId = game.id

        participants = gameParticipants[gameId]
        console.log("num participants: " + participants.length)

        _.each(participants, (socket) =>
            console.log 'firiing for socket ' + socket.id
            socket.emit('resume', {id: @gameId})
        )
    )

    socket.on('disconnect', () ->
        console.log 'gotDisconnect'

        socketGameId = socketIdGameIdMap[socket.id]

        console.log('gameid for disconnecting socket ' + socketGameId)
        participantsArray = gameParticipants[socketGameId]

        if participantsArray.length == 1
            gameParticipants[socketGameId] = undefined
        else
            gameSocketListIndex = gameParticipants[socketGameId].indexOf(socket)
            gameParticipants[socketGameId].splice(gameSocketListIndex, 1)

        allSocketsListIndex = allSockets.indexOf(socket)
        allSockets.splice(allSocketsListIndex, 1)
    )

)

fireEventToSocket = (eventName, eventPayload, socket) ->
    console.log "firing event " + eventName + " to socket id " + socket.id
    socket.emit(eventName, eventPayload)