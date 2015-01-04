#vertex-tool.coffee

BaseTool = require './tool'

class VertexTool extends BaseTool
  constructor: (args)->
    @target = args.target
    @hitArea = args.hitArea
    @toolBox = args.toolBox

  modifyVertex: (origin, ev)->
    p = @computeDelta origin, ev
    @hitArea.points[@target] = p
    
  up: (origin, ev)->
    @modifyVertex origin, ev
    @toolBox.popTool()
    true
    
  move: (origin, ev)->
    @modifyVertex origin, ev
    true
    
  down: ()->
    true
    
module.exports = VertexTool