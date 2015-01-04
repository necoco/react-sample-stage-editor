#image.coffee
React = require 'react'
art = require 'react-art'
caffeine = require 'react-caffeine'

caffeine.register
  Image:
    handleOnLoad: (ev)->
      img = @getDOMNode()
      cx = @props.width / 2
      cy = @props.height / 2
      dx = img.width / 2
      dy = img.height / 2
      @setState left: cx - dx, top: cy - dy

    getInitialState: ()->
      {left: 0, top: 0}

    render: ->
      caffeine @, ($)->
        @img
          onLoad: $.handleOnLoad
          src: @props.src
          style:
            position: 'absolute'
            left: $.state.left
            top: $.state.top