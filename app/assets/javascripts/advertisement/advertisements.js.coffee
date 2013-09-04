# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


if window.jQuery
  alert("Yeah!")
else
  alert("Doesn't Work")


$("#show_hide_button").click ->
  alert('Hello world!')
  $("#form_to_hide").show('slow')