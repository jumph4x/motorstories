$ ->
  'use strict'

  $.fn.fillOptionsWith = (data, attr, prefix) -> 
    options = prefix
    $.each(
      data,
      (idx, value) ->
        options += '<option value="' + value + '">' + value + '</option>'
    )
    this.html(options)
    this.removeAttr('disabled').show()
    $("option:first", this).attr('selected', 'selected')

  container_el = $('.mmy-selector')
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

    unless container_el.hasClass('redirectable')
      return false

    if make == ''
      return false

    param_string = 'make=' + make
    if model != ''
      param_string += '&model=' + model
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
      "/proto_vehicles/model_index?make=" + make,
      { format: "json" },
      (data) -> 
        model_el.fillOptionsWith(data, 'model', '<option value="">Model</option>')
        year_el.html('<option value="">Year</option>').attr('disabled','disabled')
    )
    btn_el.removeAttr('disabled')

  model_el.change ->
    make = make_el.val()
    model = $(this).val()

    if model == ''
      return true
    $.getJSON(
      "/proto_vehicles/year_index?model=" + model + '&make=' + make,
      { format: "json" },
      (data) -> 
        year_el.fillOptionsWith(data, 'year', '<option value="">Year</option>')
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
