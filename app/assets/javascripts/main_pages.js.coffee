# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#task_due_date").datepicker()

  $("span").hover \
    (-> $(this).css("background-color", "#c0c0c0")), \
    (-> $(this).css("background-color", "white"))

