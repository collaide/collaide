canvas = false
offcanvas = () ->
  firstSignUp = true
  firstSignIn = true
  $(document).on('click', '#header-sign-up-button', (e)->
    if($('[data-offcanvas]').hasClass('move-left') and canvas == 'sign-up')
      console.log 'closing sign up'
#      firstSignIn = true
#      firstSignUp = true
    if canvas != 'sign-up'
      offPanel = $('aside.right-off-canvas-menu')
      canvas = 'sign-up'
      newCanvasContent = $('#get-header-sign-up-panel').html()
      #console.log newCanvasContent
      offPanel.css('background-color', '#3D5164')
      offPanel.empty()
      offPanel.html(newCanvasContent)
      if firstSignUp and firstSignIn
        firstSignUp = false
      else
        stop(e)
        console.log 'j ai stopé la fermeture de sign up'
        offPanel.hide()
        offPanel.show('slow')
  )
  $(document).on('click', '#header-sign-in-button', (e)->
    if($('[data-offcanvas]').hasClass('move-left') and canvas == 'sign-in')
      console.log 'closing sign in'
#      firstSignIn = true
#      firstSignUp = true
    if canvas != 'sign-in'
      offPanel = $('aside.right-off-canvas-menu')
      canvas = 'sign-in'
      newCanvasContent = $('#get-header-sign-in-panel').html()
      offPanel.css('background-color', '#F6F6F7')
      offPanel.empty()
      offPanel.html(newCanvasContent)
      if firstSignIn and firstSignUp
        firstSignIn = false
      else
        stop(e)
        console.log 'j ai stopé la fermeture de sign in'
        offPanel.hide()
        offPanel.show('slow')
  )
  $(document).on('close.fndtn.offcanvas', '[data-offcanvas]', () ->
    firstSignIn = true
    firstSignUp = true
    console.log 'closing'
  )
stop = (event) ->
  event.stopImmediatePropagation()
  event.preventDefault()
$ ->
  # enable select2 js
  canvas = false
  offcanvas()
  $('.s2').select2()
$(document).on('page:load', ->
  canvas = true
  $('.s2').select2()
)
Turbolinks.enableTransitionCache();

