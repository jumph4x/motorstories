//= require jquery
//= require jquery_ujs
//= require foundation
//= require select2
//= require parsley
//= require './mmy_selector'
//= require './vehicles'
//= require './jquery.fittext'

$(document).ready(function(){
  $(document).foundation();
  $("#hero h1").fitText(2.5, { minFontSize: '24px' });
  $(".pitch").fitText(5, { minFontSize: '16px', maxFontSize: '35px' });
  $(".fit").fitText(2.5, {minFontSize: '16px'});
});
