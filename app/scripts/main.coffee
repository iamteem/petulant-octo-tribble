setup = ->
  setupTimeline = (id, options = {}) ->
    paper = Raphael(id, 500, 50)
    line = paper.path("M0 25L500 25").attr
      "stroke-width": 3
      "stroke": options.fillColor
    paper

  addBubble = (text, paper, options = {}) ->
    circle = paper.circle(15, 25, 15).attr
      "stroke-width": 0
      "fill": options.fillColor
    label = paper.text(15, 25, text).attr
      "font-size": 10
      "stroke": options.textColor
    group = paper.set()
    group.push(circle, label)
    end = 500 - 15
    group.animate(cx: end, x: end, 3000, 'linear', -> group.remove())

  aColors = { fillColor: "blue", textColor: "white" }
  aPaper = setupTimeline "a-timestream", aColors
  bColors = { fillColor: "red", textColor: "white" }
  bPaper = setupTimeline "b-timestream", bColors

  # streams
  aClick = $('#button-a').asEventStream('click')
  bClick = $('#button-b').asEventStream('click')

  # side effects
  aClick.map(["A", aPaper, aColors]).onValues(addBubble)
  bClick.map(["B", bPaper, bColors]).onValues(addBubble)
$(setup)
