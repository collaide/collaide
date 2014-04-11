$ ->
  # enable select2 js
  $('.s2').select2()

$('#new_topic').submit ->
  #alert $('.editable').html()
  $('#topic_message').val($('.editable').html())

$ ->
  $('.medium_editor').submit ->
    $(this).children('.hide').children('.input').children('.medium_text').val($(this).children('.row').children('.columns').children('.editable').html())