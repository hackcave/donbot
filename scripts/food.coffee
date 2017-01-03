# Description:
#   Order random food combo for h4 and ccd
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   @donbot order food for me
#   @donbot order coffee for me
#
# Author:
#   shikher

food = ['Tava paneer', 'Chiken butter rice', 'Paneer Butter rice', 'Kadhai Paneer', 'Ever hear of fasting fatass']
coffee = ['Crunchy Frappe', 'Garlic Bread', 'Cafe Americano', 'Cafe Latte', 'Double shot']

module.exports = (robot) ->
  robot.hear /\border food for me\b/, (msg) ->
    msg.send msg.random food

module.exports = (robot) ->
  robot.hear /\border coffee for me\b/, (msg) ->
    msg.send msg.random coffee

