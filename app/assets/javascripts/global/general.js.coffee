$ ->
  # enable select2 js
  $('.s2').select2()
  offcanvas()
$(document).on('page:load', ->
  $('.s2').select2()
  offcanvas()
)
Turbolinks.enableTransitionCache();

offcanvas = ()->
#  $("#header-sign-up-button").click() ->
#    $('.off-canvas-wrap').foundation('offcanvas', 'open', 'move-right');


#$(document).on 'page:restore', ->
#  $('body').show 500