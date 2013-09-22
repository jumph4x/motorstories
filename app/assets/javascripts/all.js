//= require 'vendor/jquery'
//= require './modernizr'
//= require 'foundation/foundation'
//= require 'foundation/foundation.topbar'
//= require 'foundation/foundation.forms'
//= require 'foundation/foundation.tooltips'
//= require select2
//= require parsley
//= require './mmy_selector'
//= require './vehicles'
//= require './jquery.fittext'

$(document).ready(function(){
  $(document).foundation();
  $("#hero h1").fitText(2.5, { minFontSize: '24px' });
});
