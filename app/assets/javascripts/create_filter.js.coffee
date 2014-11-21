#= require filter

filters = _.map(attrs, (attr) ->
  container = "div.#{attr}"
  $("<div></div>").attr({'class': attr})
      .appendTo('.filter')
  filter = new AttrFilter(container, attr)
  filter.build(buyers)
  filter
)
