#workspace.coffee
React = require 'react'
caffeine = require 'react-caffeine'

LineTool = require './line-tool'

require './hit-area'
require './image'


caffeine.register
  Workspace:
    handleDragOver: (ev)->
      ev.stopPropagation()
      ev.preventDefault()
      
    handleMouseUp: (ev)->
      tool = @state.tool
      tool.up @origin(), ev
      if tool.hitArea().closed
        tool.clear()
        @setState editing: false

    handleMouseDown: (ev)->
      tool = @state.tool
      tool.down @origin(), ev
     
      unless @state.editing
        @props.hitAreaList.push tool.hitArea()
        @setState editing: true
      @forceUpdate()

    handleMouseMove: (ev)->
      tool = @state.tool
      @forceUpdate() if tool.move @origin(), ev
    
    origin: ()->
      s = @refs.image.state
      {x: s.left, y: s.top}
      
    handleDrop: (ev)->
      ev.stopPropagation()
      ev.preventDefault()
    
      file = ev.dataTransfer.files[0]
      if file?
        reader = new FileReader()
        reader.onload = (fileEvent)=>
          @setState src: fileEvent.target.result
        reader.readAsDataURL file

    getInitialState: ()->
      {src: null, tool: new LineTool(), editing: false}
        
    render: ->
      tool = @state.tool
      caffeine @, ($)->
        @div
          onDrop: $.handleDrop
          onDragOver: $.handleDragOver
          onMouseDown: $.handleMouseDown
          onMouseUp: $.handleMouseUp
          onMouseMove: $.handleMouseMove
          style:
            width: @props.width
            height: @props.height
          , ->
            @Image
              src: $.state.src
              width: @props.width
              height: @props.height
              ref: 'image'

            @Surface
              style:
                position: 'absolute'
              width: @props.width
              height: @props.height
              , ->
                for hitArea in @props.hitAreaList
                  @HitArea
                    hitArea: hitArea
                    origin: $.origin()