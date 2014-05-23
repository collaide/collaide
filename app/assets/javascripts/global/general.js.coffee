$ ->
  # enable select2 js
  $('.s2').select2()
$(document).on('page:load', ->
  $('.s2').select2()
)
Turbolinks.enableTransitionCache();

#$(document).on 'page:restore', ->
#  $('body').show 500