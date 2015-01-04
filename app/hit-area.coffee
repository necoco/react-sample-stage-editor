#hit-area.coffee
React = require 'react'
art = require 'react-art'
caffeine = require 'react-caffeine'

require './vertex'


caffeine.register
  HitArea:
    createPath: (origin, ps)->
      path = new art.Path()
        .moveTo origin.x + ps[0].x, origin.y + ps[0].y
      for p in ps[1..]
        path.lineTo origin.x + p.x , origin.y + p.y
      path.close()
  
    render: ->
      origin = @props.origin
      caffeine @, ($)->
        @Group ->
          if @props.hitArea.closed
            @Shape
              d: $.createPath origin, @props.hitArea.points
              fill: "#ff000055"

          for p, i in @props.hitArea.points
            @Vertex
              x: p.x + origin.x
              y: p.y + origin.y
              toolBox: @props.toolBox
              hitArea: @props.hitArea
              target: i