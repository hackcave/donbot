# Description:
#   Displays and/or generates images for the Natkhat Adarsh
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_MEMEGENERATOR_USERNAME -- Username on MemeGenerator.net
#   HUBOT_MEMEGENERATOR_PASSWORD -- Password for account on MemeGenerator.net
#
# Commands:
#   <Quote natkhat statement from Adarsh> natkhat adarsh - Shows the natkhat adarsh meme
#
# Notes:
#   None
#
# Author:
#   shikher

module.exports = (robot) ->
  robot.hear /(.*) natkhat adarsh/i, (msg) ->
    generateMeme msg, 6913117, 16473882, msg.match[1], "Natkhat Adarsh"

generateMeme = (msg, generatorID, imageID, msg1, msg2) ->
  if not process.env.HUBOT_MEMEGENERATOR_USERNAME
    msg.send "Error: You must specify your MemeGenerator.net username"
  if not process.env.HUBOT_MEMEGENERATOR_PASSWORD
    msg.send "Error: You must specify your MemeGenerator.net pasword"
  if not (process.env.HUBOT_MEMEGENERATOR_USERNAME and process.env.HUBOT_MEMEGENERATOR_PASSWORD)
    return
  url = "http://version1.api.memegenerator.net/Instance_Create?username=#{ process.env.HUBOT_MEMEGENERATOR_USERNAME }&password=#{ process.env.HUBOT_MEMEGENERATOR_PASSWORD }&languageCode=en&generatorID=#{ generatorID }&imageID=#{ imageID }&text0=#{ encodeURIComponent(msg1) }&text1=#{ encodeURIComponent(msg2) }"
  msg.http(url).get() (err, res, body) ->
    resp = JSON.parse(body)
    msg.send resp.result.instanceImageUrl
