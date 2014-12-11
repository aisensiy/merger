#= require filter

$ ->
  return if !$('body.total-ctrl.search_buyers_result-md').size()

  build_jqgrid(
    '#search-buyer-grid-table',
    result,
    fixed_buyer_attrs,
    buyer_attrs,
    false
  )
