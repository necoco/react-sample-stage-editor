#line-tool.coffee

CLOSE_DISTANCE = 10

class LineTool
  constructor: ()->
    @current = @newHitArea()
    
  setHitAreaList: (list)->
    @hitAreaList = list
    
  clear: ()->
    @current = @newHitArea()
    
  newHitArea: ()->
    points: []
    closed: false
      
  addPoint: (origin, ev)->
    @current.points.push @computeDelta origin, ev
    
  modifyPoint: (origin, ev)->
    @current.points[@current.points.length-1] = @computeDelta origin, ev    

  computeDelta: (b, ev)->
    {x: ev.clientX - b.x, y: ev.clientY - b.y}

  nearStartPoint: (p)->
    if @current.points[2]?
      b = @current.points[0]
      dx = p.x - b.x
      dy = p.y - b.y
      dx*dx+dy*dy < CLOSE_DISTANCE*CLOSE_DISTANCE

  hitArea: ()->
    @current
        
  move: (origin, ev)->
    if !@current.closed and @current.points[0]?
      @modifyPoint origin, ev
      return true
    return false
  
  up: (origin, ev)->
    @modifyPoint origin, ev
    p = @computeDelta origin, ev
    if @nearStartPoint p
      @current.closed = true
      @current.points.pop()
    else
      @addPoint origin, ev

    if @current.closed
      @clear()
    return true


  down: (origin, ev)->
    if @current.points.length == 0
      @hitAreaList.push @hitArea()
      @addPoint origin, ev
      
    return true
    

module.exports = LineTool