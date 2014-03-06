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
  aClicks = $('#button-a').asEventStream('click')
  bClicks = $('#button-b').asEventStream('click')
  keydowns = $(document).asEventStream('keydown')
  keycodeIs = (code) -> ((event) -> event.which is code)
  aPresses = keydowns.filter(keycodeIs(65))
  bPresses = keydowns.filter(keycodeIs(66))
  aInputs = aClicks.merge(aPresses)
  bInputs = bClicks.merge(bPresses)

  # side effects
  aInputs.map(["A", aPaper, aColors]).onValues(addBubble)
  bInputs.map(["B", bPaper, bColors]).onValues(addBubble)
$(setup)
