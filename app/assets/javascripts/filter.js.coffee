class AttrFilter
  constructor: (@container, @attr, @attr_text, @callback) ->
    @width = $(@container).width()
    @height = 120
    @extent = null

  build: (buyers) ->
    margin =
      top: 15
      right: 10
      bottom: 50
      left: 10

    width = @width - margin.left - margin.right
    height = @height - margin.top - margin.bottom

    svg = d3.select(@container).append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)

    g = svg.append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

    svg.append('text')
        .attr('class', 'title')
        .attr('x', width / 2 - 70).attr('y', 10)
        .text(@attr_text)
        .style("font-size", "10px")

    values = _.map(buyers, (v) => v[@attr])
    x = d3.scale.linear().range([0, width]).domain([0, d3.max(values)])

    data = d3.layout.histogram().bins(x.ticks(20))(values)

    y = d3.scale.linear().range([height, 0]).domain([0, d3.max(data, (d) -> d.y)])

    tick = data[0].dx

    self = this

    brushed = () ->
      extent0 = brush.extent()
      extent1 = null

      # if dragging, preserve the width of the extent
      if d3.event.mode == "move"
        d0 = Math.round(extent0[0] / tick) * tick
        d1 = d0 + extent0[1] - extent0[0]
        extent1 = [d0, d1]
      else # otherwise, if resizing, round both dates
        d0 = Math.round(extent0[0] / tick) * tick
        d1 = Math.round(extent0[1] / tick) * tick
        extent1 = [d0, d1]

        if extent1[0] >= extent1[1]
          extent1[0] = Math.floor(extent0[0] / tick) * tick
          extent1[1] = Math.ceil(extent0[1] / tick) * tick

      extent1 = _.map(extent1, Math.round)
      d3.select(this).call(brush.extent(extent1))
      self.callback(extent1) if self.callback
      self.extent = extent1
      svg.select('text.title').text("#{self.attr_text} #{extent1[0]} - #{extent1[1]}")

    brush = d3.svg.brush().x(x).extent([0, data[3].x])
        .on('brush', brushed)

    xAxis = d3.svg.axis().scale(x).orient("bottom")

    bar = g.selectAll('g').data(data).enter().append('g')
             .attr('transform', (d) ->
               "translate(#{x(d.x)}, #{y(d.y)})"
             )
             .attr('class', 'bar')

    bar.append('rect')
       .attr('x', 1)
       .attr('height', (d) ->
         height - y(d.y)
       )
       .attr('width', x(data[0].dx) - 1)

    bar.append("text")
       .attr("dy", "8px")
       .attr("y", 6)
       .attr("x", x(data[0].dx) / 2)
       .attr("text-anchor", "middle")
       .text((d) -> d.y)

    g.append("g")
       .attr("class", "x axis")
       .attr("transform", "translate(0," + height + ")")
       .call(xAxis)
       .selectAll('text')
       .style('text-anchor', 'end')
       .attr("dx", "-.8em")
       .attr("dy", ".15em")
       .attr("transform", "rotate(-35)")

    gBrush = g.append("g")
        .attr("class", "brush")
        .call(brush)

    gBrush.selectAll("rect").attr("height", height)

window.AttrFilter = AttrFilter
