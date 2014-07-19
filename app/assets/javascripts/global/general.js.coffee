offcanvas = () ->
  canvas = false
  firstSignUp = true
  firstSignIn = true
  offPanel = $('aside.right-off-canvas-menu')
  $(document).on('click', '#header-sign-up-button',  (e)->
    console.log('salut')
    if canvas != 'sign-up'
      canvas = 'sign-up'
      newCanvasContent = $('#get-header-sign-up-panel').html()
      offPanel.css('background-color', '#3D5164')
      offPanel.empty()
      offPanel.html(newCanvasContent)
      if firstSignUp and firstSignIn
        firstSignUp = false
      else
        stop(e)
        offPanel.hide()
        offPanel.show('slow')
  )
  $(document).on('click', '#header-sign-in-button', (e)->
    console.log('bonjour')
    if canvas != 'sign-in'
      canvas = 'sign-in'
      newCanvasContent = $('#get-header-sign-in-panel').html()
      offPanel.css('background-color', '#F6F6F7')
      offPanel.empty()
      offPanel.html(newCanvasContent)
      if firstSignIn and firstSignUp
        firstSignIn = false
      else
        stop(e)
        offPanel.hide()
        offPanel.show('slow')
  )
stop = (event) ->
  event.stopImmediatePropagation()
  event.preventDefault()
  console.log 'callCount'
$ ->
  # enable select2 js
  offcanvas()
  $('.s2').select2()
$(document).on('page:load', ->
  offcanvas()
  $('.s2').select2()
)
Turbolinks.enableTransitionCache();

