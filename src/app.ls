require! ['express', 'http', './promise-primeval', './promise-vow']

app = express!

app.set 'port', 4000

app.get '/', !(req, res)->
  res.send 'hello'

<-! http.create-server(app).listen app.get 'port'
console.log 'Express sever listening on port ' + app.get 'port'
