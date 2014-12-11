$ ->
  return if !$('body.total-ctrl.search_targets_result-md').size()

  build_jqgrid(
    '#search-target-grid-table',
    result,
    fixed_target_attrs,
    target_attrs,
    false
  )
