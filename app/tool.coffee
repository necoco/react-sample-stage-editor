
class BaseTool
  computeDelta: (b, ev)->
    {x: ev.clientX - b.x, y: ev.clientY - b.y}


module.exports = BaseTool