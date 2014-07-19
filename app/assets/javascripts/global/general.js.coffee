headerOffCanvas = () ->
  canvas = false
  $('#header-sign-up-button').click ->
    if canvas != 'sign-up'
      canvas = 'sign-up'
      newCanvasContent = $('#get-header-sign-up-panel').html()
      $('aside.right-off-canvas-menu').css('background-color', '#3D5164')
      $('aside.right-off-canvas-menu').empty()
      $('aside.right-off-canvas-menu').html(newCanvasContent)
  $('#header-sign-in-button').click ->
    if canvas != 'sign-in'
      canvas = 'sign-in'
      newCanvasContent = $('#get-header-sign-in-panel').html()
      $('aside.right-off-canvas-menu').css('background-color', '#F6F6F7')
      $('aside.right-off-canvas-menu').empty()
      $('aside.right-off-canvas-menu').html(newCanvasContent)

$ ->
  # enable select2 js
  $('.s2').select2()
  headerOffCanvas()
$(document).on('page:load', ->
  $('.s2').select2()
  headerOffCanvas()
)
Turbolinks.enableTransitionCache();

