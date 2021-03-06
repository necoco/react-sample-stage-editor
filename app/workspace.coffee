#workspace.coffee
React = require 'react'
caffeine = require 'react-caffeine'

ToolBox = require './tool-box'

require './hit-area'
require './image'


caffeine.register
  Workspace:
    handleDragOver: (ev)->
      ev.stopPropagation()
      ev.preventDefault()
      
    handleMouseUp: (ev)->
      @forceUpdate() if @currentTool().up @origin(), ev

    handleMouseDown: (ev)->
      @forceUpdate() if @currentTool().down @origin(), ev

    handleMouseMove: (ev)->
      @forceUpdate() if @currentTool().move @origin(), ev
    
    currentTool: ()->
      @state.toolBox.currentTool()
      
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
      {src: null, toolBox: new ToolBox(), editing: false}
        
    render: ->
      @state.toolBox.setHitAreaList @props.hitAreaList
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
                    toolBox: $.state.toolBox
                    origin: $.origin()