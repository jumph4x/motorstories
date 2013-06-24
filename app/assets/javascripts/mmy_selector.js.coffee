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

  $(".mmy-selector select option:first-child").attr("selected","selected")

  make_el = $('.mmy-selector #make')
  model_el = $('.mmy-selector #model')
  year_el = $('.mmy-selector #year')

  make_el.change ->
    make = $(this).val()

    if make == ''
      return true
    $.getJSON(
      "/models?make_slug=" + make,
      { format: "json" },
      (data) -> 
        model_el.fillOptionsWith(data, '<option value="">Model</option>')
        year_el.html('<option value="">Year</option>').attr('disabled','disabled')
    )

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

  year_el.change ->
    make = make_el.val()
    model = model_el.val()
    year = $(this).val()

    if year == ''
      return true
    window.location.replace("/redirects/vehicles_index?model_slug=" + model + '&make_slug=' + make + '&year=' + year)
