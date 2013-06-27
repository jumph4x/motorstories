$ ->
  'use strict'

  # new project stuff
  # $('#select2').select2({ placeholder: 'hello' })

  # change +/- icon and expand/contract
  $('.section-title, .section-icon').on 'click', ->
    $section = $(this).parent()
    if $section.hasClass 'expanded'
      $section.removeClass 'expanded'
      $section.children('.section-icon').html "+"

    else
      $section.addClass 'expanded'
      $section.children('.section-icon').html "-"
      
  $('.tool-tip').hide()
  $('.input-append').on 'mouseover mouseenter', ->
    $(this).children('.tool-tip').show()
  .on 'mouseout mouseleave', ->
    $(this).children('.tool-tip').hide()
