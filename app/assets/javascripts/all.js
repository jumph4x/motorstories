//= require 'vendor/jquery'
//= require jquery_ujs
//= require './modernizr'
//= require 'foundation/foundation'
//= require 'foundation/foundation.topbar'
//= require 'foundation/foundation.forms'
//= require 'foundation/foundation.tooltips'
//= require 'foundation/foundation.alerts'
//= require select2
//= require parsley
//= require './mmy_selector'
//= require './vehicles'
//= require './jquery.fittext'
//= require './foundation-datepicker'

$(document).ready(function(){
  $(document).foundation();
  $("#hero h1").fitText(2.5, { minFontSize: '24px' });
  $(".pitch").fitText(5, { minFontSize: '16px', maxFontSize: '35px' });
  $('.date').fdatepicker();
});
