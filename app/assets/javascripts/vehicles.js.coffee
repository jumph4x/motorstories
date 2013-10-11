$ ->
  'use strict'
  progress = 4
  completed = []
  $(".progress .meter").css('width', progress + '%')

  $(".section-controls .button").click () ->
    section = $(this).parents("[data-name]")
    section_name = section.attr('data-name')
    
    if !(section_name in completed)
      completed.push section_name
      progress += 12
      $(".progress .meter").css('width', progress + '%')
      
      $('.progress-headings .' + section_name).addClass("done")
    
    section.removeClass('expanded') 
    next_section = section.next("[data-name]")
    if next_section.length > 0
      next_section.addClass('expanded') 
    else
      section.parents('form').submit()
