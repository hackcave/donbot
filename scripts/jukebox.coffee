# Description:
#   Notify currently playing song on the jukebox
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_JUKEBOX_ROOM
#   HUBOT_JUKEBOX_LASTFM_USER
#   HUBOT_LASTFM_APIKEY
#
# Commands:
#   None
#
# Author:
#   vikraman

updateSong = (robot) ->
  room = process.env.HUBOT_JUKEBOX_ROOM.replace /^#/, ""
  user = process.env.HUBOT_JUKEBOX_LASTFM_USER
  apiKey = process.env.HUBOT_LASTFM_APIKEY
  robot.http('http://ws.audioscrobbler.com/2.0/?')
    .query(method: 'user.getrecenttracks', user: user, api_key: apiKey, format: 'json')
    .get() (err, res, body) ->
      results = JSON.parse(body)
      if results.error
        return
      song = results.recenttracks.track[0]
      currentJukeboxSong = "#{song.name} by #{song.artist['#text']}"
      if robot.brain.data.jukebox != currentJukeboxSong
        robot.brain.data.jukebox = currentJukeboxSong
        robot.messageRoom room, "Now playing: #{currentJukeboxSong}"

module.exports = (robot) ->
  robot.brain.data.jukebox or= null
  robot.brain.on 'loaded', ->
    setInterval () ->
      updateSong robot
    , 90001
