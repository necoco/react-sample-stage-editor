#main.coffee
React = require 'react'
art = require 'react-art'
caffeine = require 'react-caffeine'

require './workspace'

caffeine.registerClass art
caffeine.registerClass
  Circle: require 'react-art/shapes/circle'

hitArea = []

window.onload = ->
  target = document.getElementById 'target'


  React.render (caffeine ->
    @Workspace
      width: target.clientWidth
      height: target.clientHeight
      hitAreaList: hitArea
  ), target