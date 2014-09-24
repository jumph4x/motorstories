//= require jquery
//= require jquery_ujs
//= require foundation
//= require select2
//= require './jquery.fittext'
//= require './mmy_selector'
//= require './vehicles'

$(document).ready(function(){
  $(document).foundation();
  $('.fit').fitText(1.4);
  $(".select2").select2();
});
