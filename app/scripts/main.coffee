setup = ->
  aPaper = Raphael("a-timestream", 500, 50)
  line = aPaper.path("M0 25L500 25").attr("stroke-width:": 3, "stroke": "blue")
  addBubble = (text, paper) ->
    circle = paper.circle(15, 25, 15).attr("stroke-width": 0, "fill": "blue")
    label = paper.text(15, 25, text).attr("font-size": 10, "stroke": "white")
    group = paper.set()
    group.push(circle, label)
    end = 500 - 15
    group.animate(cx: end, x: end, 3000, 'linear', -> group.remove())

  aClicks = $("#button-a").asEventStream('click')
  aPapers = Bacon.constant(aPaper)
  aLabels = Bacon.constant("A")

  # TODO: finish this
$(setup)
