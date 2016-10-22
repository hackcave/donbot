# Description:
#   "Accepts a message and sends it to the notifications room"
#
# Dependencies:
#   "querystring": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLs:
#   GET /hubot/say?message=<message>
#

querystring = require('querystring')

module.exports = (robot) ->
  robot.router.get "/hubot/notify", (req, res) ->
    query = querystring.parse(req._parsedUrl.query)
    message = query.message
    room = process.env.HUBOT_NOTIFY_ROOM.replace /^#/, ""

    robot.logger.info "Message '#{message}' received for room '#{room}'"

    envelope = {}
    envelope.user = {}
    envelope.user.room = envelope.room = room if room
    envelope.user.type = 'groupchat'

    if message
      robot.send envelope, message

    res.writeHead 200, {'Content-Type': 'text/plain'}
    res.end 'Thanks\n'
