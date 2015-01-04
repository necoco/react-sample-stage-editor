#hit-area.coffee
React = require 'react'
art = require 'react-art'
caffeine = require 'react-caffeine'

caffeine.register
  Vertex:
    handleDown: (ev)->
      @props.toolBox.pushTool('vertex', {target: @props.target, hitArea: @props.hitArea}) unless @props.toolBox.isBusy()
    
    render: ->
      caffeine @, ($)->
        @Circle
          x: @props.x
          y: @props.y
          onMouseDown: $.handleDown
          fill: '#ff0000ff'
          radius: 10
          
