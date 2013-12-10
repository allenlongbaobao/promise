require! ['vow']

user-id = 1
# callback usage
get-user-name = !(user-id, callback)->
  if user-id is 0
    callback new Error 'user-id is error'
  else
    callback 'allen'

(name) <-! get-user-name user-id 
if name instanceof Error
  console.log "i got Error: ", name.message
else
  console.log "i got name: ", name


# promise usage
get-user-age = !(user-id)->
  promise = vow.promise!
  promise.notify 'got you request'
  if user-id is 0
    promise.reject new Error 'user-id is error'
  else
    promise.fulfill '21'
  return promise

get-user-age(user-id).then !(age)->
  console.log 'age is: ', age
,!(err)->
  console.log err.message
,!(data)->
  console.log "promise is notified"



