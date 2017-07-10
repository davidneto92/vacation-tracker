//= require jquery
//= require jquery_ujs
//= require jquery-tablesorter
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });


$(document).ready(function()
  {
    $.noConflict();
    $("#parksTable").tablesorter();
  }
);
