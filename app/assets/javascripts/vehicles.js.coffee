$ ->
  $('input[type="checkbox"][data-category]').bind 'change', ->
    cat = $(this).attr('data-category')
    bg = $('.icon[data-category="' + cat + '"]')
    if $(this).prop('checked')
      bg.addClass 'modded'
    else
      bg.removeClass 'modded'
