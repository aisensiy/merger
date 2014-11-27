#= require filter

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

  click_button = () ->
    id = $('#similar-buyer-grid-table').jqGrid('getGridParam','selrow')
    return if not id

    params = {
      'selected_buyer_id': id
    }
    window.location = "#{$(this).attr('url')}?#{$.param(params)}"

  $('#get_similar_target').click(click_button)
