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
    this.select2("destroy")
    this.select2({placeholder: attr})

  container_el = $('.mmy-selector')
  make_el = $('.mmy-selector #make')
  model_el = $('.mmy-selector #model')
  year_el = $('.mmy-selector #year')
  btn_el = $(".mmy-selector #mmy-submit")
  new_btn_el = $(".mmy-selector .new-project-redirect")

  if make_el.val() == ''
    btn_el.attr('disabled','disabled')

  paramString = () ->
    make = make_el.val()
    model = model_el.val()
    year = year_el.val()

    param_string = 'make=' + make
    if model != ''
      param_string += '&model=' + model
    if year != ''
      param_string += '&year=' + year

    return param_string

  mmyRedirect = () ->
    unless container_el.hasClass('redirectable')
      return false
    if make_el.val() == ''
      return false
    window.location.replace("/redirects/vehicles_index?" + paramString())

  newRedirect = () ->
    if make_el.val() == ''
      return false
    window.location.replace("/projects/new?" + paramString())

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
        model_el.fillOptionsWith(data, 'Model', '<option></option>')
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
        year_el.fillOptionsWith(data, 'Year', '<option></option>')
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

  new_btn_el.click ->
    newRedirect()
