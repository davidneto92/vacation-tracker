//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

//= require jquery.tablesorter.js

//= require file_in_lib
//= require file_in_vendor

$(function(){ $(document).foundation(); });

$(document).ready(function() {
  $('table.tablesorter').tablesorter();
});

$(document).ready(function()
    {
        $("#parksTable").tablesorter();
    }
);
