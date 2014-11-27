$ ->
  return if !$('body.total-ctrl.get_similar_targets-md').size()

  grid_selector = '#similar-target-grid'

  filted_buyers = null
  filters = _.map(target_attrs, (name, attr) ->
    container = "div.#{attr}"
    $("<div></div>").attr({'class': "#{attr} col-md-6"})
    .appendTo('.filter')

    callback = ((attr) ->
      return () ->
        filted_buyers = targets
        for filter in filters
          if not filter.extent
            continue
          extent = filter.extent
          attr = filter.attr
          filted_buyers = _.filter(filted_buyers, (buyer) ->
            buyer[attr] <= extent[1] and buyer[attr] >= extent[0]
          )
        $(grid_selector).jqGrid('clearGridData')
        $(grid_selector).jqGrid('setGridParam', {
          'data': filted_buyers
        })
        $(grid_selector).trigger('reloadGrid')
    )(attr)

    filter = new AttrFilter(container, attr, name, callback)
    filter.build(targets)
    filter
  )

  build_jqgrid(
    grid_selector,
    targets,
    fixed_target_attrs,
    target_attrs,
    false
  )

  build_jqgrid(
    '#reference-buyer-grid-table',
    reference_buyers,
    fixed_buyer_attrs,
    buyer_attrs,
    false
  )

  build_jqgrid(
    '#selected-buyer-grid-table',
    selected_buyers,
    fixed_buyer_attrs,
    buyer_attrs,
    false
  )

  click_button = () ->
    id = $('#similar-buyer-grid-table').jqGrid('getGridParam','selrow')
    return if not id

    params = {
      'selected_buyer_id': id
    }
    window.location = "#{$(this).attr('url')}?#{$.param(params)}"

  $('#get_similar_target').click(click_button)