$ ->
  # enable select2 js
  $('.s2').select2()

$('#new_topic').submit ->
  #alert $('.editable').html()
  $('#topic_message').val($('.editable').html())