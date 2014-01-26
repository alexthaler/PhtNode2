express = require('express')


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

app.listen(3000)