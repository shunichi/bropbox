$(document).ready ->
  $('.tree-item').each ->
    $(this).css('padding-left', $(this).data('depth')+'em')
  $('.tree-item').on 'click', ->
    $('#js-tree').data('destination-id', $(this).data('id'))
    $('.tree-item').removeClass('tree-item--selected')
    $(this).addClass('tree-item--selected')
    return false
return