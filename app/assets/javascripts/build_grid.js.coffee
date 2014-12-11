build_models = (attrs, type) ->
  _.map(attrs, (attr) ->
    {'name': attr, 'sorttype': type, 'width': 80}
  )


build_jqgrid = (selector, objects, fixed_attrs, attrs, multiselect) ->
  $parent_column = $(selector).closest('[class*="col-"]')
  $(window).on('resize.jqGrid', () ->
    $(selector).jqGrid('setGridWidth', $parent_column.width())
  )
  $(selector).jqGrid
    datatype: 'local'
    data: objects
    colNames: _.values(fixed_attrs).concat(_.values(attrs))
    colModel: build_models(_.keys(fixed_attrs), 'string')
    .concat(build_models(_.keys(attrs), 'integer'))
    height: 'auto'
    multiselect: multiselect
    autowidth: false
    shrinkToFit: true
    width: '100%'
  $(window).triggerHandler('resize.jqGrid')

window.build_jqgrid = build_jqgrid