$ ->
  'use strict'

  $.fn.fillOptionsWith = (data, prefix) -> 
    options = prefix
    $.each(
      data,
      (idx, value) ->
        options += '<option value="' + value[1] + '">' + value[0] + '</option>'
    )
    this.html(options)
    this.removeAttr('disabled').show()
    $("option:first", this).attr('selected', 'selected')

  make_el = $('.mmy-selector #make')
  model_el = $('.mmy-selector #model')
  year_el = $('.mmy-selector #year')
  btn_el = $(".mmy-selector #mmy-submit")

  if make_el.val() == ''
    btn_el.attr('disabled','disabled')

  mmyRedirect = () ->
    make = make_el.val()
    model = model_el.val()
    year = year_el.val()

    if make == ''
      return false

    param_string = 'make_slug=' + make
    if model != ''
      param_string += '&model_slug=' + model
    if year != ''
      param_string += '&year=' + year

    window.location.replace("/redirects/vehicles_index?" + param_string)
    
  make_el.change ->
    make = $(this).val()

    if make == ''
      model_el.html('<option value="">Model</option>').attr('disabled','disabled')
      year_el.html('<option value="">Year</option>').attr('disabled','disabled')
      btn_el.attr('disabled','disabled')
      return true

    $.getJSON(
      "/models?make_slug=" + make,
      { format: "json" },
      (data) -> 
        model_el.fillOptionsWith(data, '<option value="">Model</option>')
        year_el.html('<option value="">Year</option>').attr('disabled','disabled')
    )
    btn_el.removeAttr('disabled')

  model_el.change ->
    make = make_el.val()
    model = $(this).val()

    if model == ''
      return true
    $.getJSON(
      "/years?model_slug=" + model + '&make_slug=' + make,
      { format: "json" },
      (data) -> 
        year_el.fillOptionsWith(data, '<option value="">Year</option>')
    )
    btn_el.removeAttr('disabled')

  year_el.change ->
    make = make_el.val()
    model = model_el.val()
    year = $(this).val()

    if year == ''
      return true
    mmyRedirect()

  btn_el.click ->
    mmyRedirect()
