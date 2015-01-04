Tools = 
  vertex: require './vertex-tool'
  line: require './line-tool'

class ToolBox
  constructor: ()->
    @toolStack = []
    @pushTool('line')
    
  isBusy: ()->
    @currentTool().isBusy()
    
  currentTool: ()->
    @toolStack[@toolStack.length-1]
    
  popTool: ()->
    @toolStack.pop()
  
  pushTool: (name, args)->
    args = args || {}
    args.toolBox = @
    console.log args
    @toolStack.push new Tools[name](args)
    
  setHitAreaList: (list)->
    tool.setHitAreaList?(list) for tool in @toolStack
    null
  
module.exports = ToolBox
