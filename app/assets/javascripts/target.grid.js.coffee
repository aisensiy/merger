#= require filter

build_models = (attrs, type) ->
  _.map(attrs, (attr) ->
    {'name': attr, 'sorttype': type}
  )

filted_buyers = null
grid_selector = '#jq-grid'

build_jqgrid = () ->
  $parent_column = $(grid_selector).closest('[class*="col-"]')
  $(window).on('resize.jqGrid', () ->
    $(grid_selector).jqGrid('setGridWidth', $parent_column.width())
  )

  $(grid_selector).jqGrid
    datatype: 'local'
    data: buyers
    colNames: _.values(fixed_attrs).concat(_.values(attrs)) #['代码', '名称', '控股人', '市值', 't - 1 市值', 't - 2 市值']
    colModel: build_models(_.keys(fixed_attrs), 'string')
                  .concat(build_models(_.keys(attrs), 'integer'))
    height: 'auto'
    multiselect: true
    caption: ""

  $(window).triggerHandler('resize.jqGrid')


$ ->
  return if !$('body.total-ctrl.get_similar_targets-md').size()

  filters = _.map(attrs, (name, attr) ->
    container = "div.#{attr}"
    $("<div></div>").attr({'class': "#{attr} col-md-6"})
        .appendTo('.filter')

    callback = ((attr) ->
      return () ->
        filted_buyers = buyers
        for filter in filters
          if not filter.extent
            continue
          extent = filter.extent
          attr = filter.attr
          # console.log extent
          # console.log attr
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
    filter.build(buyers)
    filter
  )

  build_jqgrid()

  submit_selected_buyers = () ->
    ids = $(grid_selector).jqGrid('getGridParam','selarrrow')
    params = {
      'ids': ids
      'selected_attrs': _.keys(attrs)
      'industry_id': buyers[0].industry_id
    }
    window.location = "/mockup/similar_buyer?#{$.param(params)}"

  $('#get_similar_buyer').click(submit_selected_buyers)
