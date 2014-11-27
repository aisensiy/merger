$ ->
  return if !$('body.total-ctrl.show_result-md').size()

  build_jqgrid(
    '#selected-target-grid-table',
    selected_targets,
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