require! ['util', 'http', 'debug']
Event-emitter = (require 'events').Event-emitter

# primeval promise described by event-emitter
# define promise
Promise = !->
  Event-emitter.call @

util.inherits Promise, Event-emitter

Promise.prototype.then = !(fulfilled-handler, error-handler, progress-handler)->
  if typeof fulfilled-handler is 'function'
    @.once 'success', fulfilled-handler
  if typeof error-handler is 'function'
    @.once 'error', error-handler
  if typeof progress-handler is 'function'
    @.on 'progress', progress-handler
  return @

# define deferred
Deferred = !->
  @.state = 'unfulfilled'
  @.promise = new Promise!

Deferred.prototype.resolve = !(obj)->
  @.state = 'fulfilled'
  @.promise.emit 'success', obj

Deferred.prototype.reject = !(err)->
  @.state = 'failed'
  @.promise.emit 'err', err

Deferred.prototype.progress = !(data)->
  @.promise.emit 'progress', data


# show how to use
promisify = !(res)->
  debug "--------------- promise primeval is running -----------------"
  deferred = new Deferred!
  result = ''
  res.on 'data', !(chunk)->
    result += chunk
    deferred.progress chunk

  res.on 'end', !->
    deferred.resolve result

  res.on 'error', !(err)->
    deferred.reject err

  return deferred.promise

options =
  hostname: 'www.google.com'
  port: 80
  path: '/upload'
  method: 'POST'

req = http.request options, !(res)->
  res.set-encoding 'utf-8'

  promisify(res).then !->
    console.log 'resolve successfully!'
    debug "--------------- promise primeval is end -----------------"
  , !(err)->
    console.log err
  , !(chunk)->
    console.log 'body: ' + chunk

req.on 'error', !(err)->
  console.log "problem with request: " + err.message

req.write 'data\n'
req.write 'data\n'
req.end!

