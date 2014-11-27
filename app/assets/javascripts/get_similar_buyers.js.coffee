#= require filter

build_models = (attrs, type) ->
  _.map(attrs, (attr) ->
    {'name': attr, 'sorttype': type}
  )



build_jqgrid = (selector, objects, fixed_attrs, attrs, multiselect) ->
  $parent_column = $(selector).closest('[class*="col-"]')
  $(window).on('resize.jqGrid', () ->
    $(selector).jqGrid('setGridWidth', $parent_column.width())
  )
  $(selector).jqGrid
    datatype: 'local'
    data: objects
    colNames: _.values(fixed_attrs).concat(_.values(attrs)) #['代码', '名称', '控股人', '市值', 't - 1 市值', 't - 2 市值']
    colModel: build_models(_.keys(fixed_attrs), 'string')
    .concat(build_models(_.keys(attrs), 'integer'))
    height: 'auto'
    multiselect: multiselect

  $(window).triggerHandler('resize.jqGrid')


$ ->
  return if !$('body.total-ctrl.get_similar_buyers-md').size()

  build_jqgrid(
    '#reference-buyer-grid-table',
    reference_buyers,
    fixed_buyer_attrs,
    buyer_attrs,
    false
  )

  build_jqgrid(
    '#similar-buyer-grid-table',
    result,
    fixed_buyer_attrs,
    buyer_attrs,
    false
  )
  
  submit_selected_buyers = () ->
    id = $('#similar-buyer-grid-table').jqGrid('getGridParam','selrow')
    params = {
      'selected_buyer_id': id
    }
    window.location = "#{$(this).attr('url')}?#{$.param(params)}"

  $('#get_similar_buyer').click(submit_selected_buyers)
