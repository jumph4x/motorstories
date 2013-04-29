$ ->
  'use strict'

  # new project stuff

  # change +/- icon and expand/contract
  $('.section-title, .section-icon').on 'click', ->
    $section = $(this).parent()
    if $section.hasClass 'expanded'
      $section.removeClass 'expanded'
      $section.children('.section-icon').html "+"

    else
      $section.addClass 'expanded'
      $section.children('.section-icon').html "-"
      