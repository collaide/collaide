offcanvas = () ->
  canvas = false

#  firstSignUp = true
#  firstSignIn = true
  $(document).on('click', '#header-sign-up-button', (e)->
    if canvas != 'sign-up'
      canvas = 'sign-up'
      offPanel = $('aside.right-off-canvas-menu')
      newCanvasContent = $('#get-header-sign-up-panel').html()
      offPanel.css('background-color', '#3D5164')
      offPanel.empty()
      offPanel.html(newCanvasContent)
      if isCanvasOpen()
        stop(e)
        console.log 'j ai stopé la fermeture de sign up'
        offPanel.hide()
        offPanel.show('slow')
  )
  $(document).on('click', '#header-sign-in-button', (e)->
    if(canvas != 'sign-in')
      offPanel = $('aside.right-off-canvas-menu')
      canvas = 'sign-in'
      newCanvasContent = $('#get-header-sign-in-panel').html()
      offPanel.css('background-color', '#F6F6F7')
      offPanel.empty()
      offPanel.html(newCanvasContent)
      if isCanvasOpen()
        stop(e)
        console.log 'j ai stopé la fermeture de sign in'
        offPanel.hide()
        offPanel.show('slow')
  )
  isCanvasOpen = () ->
    $('[data-offcanvas]').hasClass('move-left')

#  $(document).on('close.fndtn.offcanvas', '[data-offcanvas]', () ->
#    firstSignIn = true
#    firstSignUp = true
#    console.log 'closing'
#  )

stop = (event) ->
  event.stopImmediatePropagation()
  event.preventDefault()
$ ->
  # enable select2 js
  offcanvas()
  $('.s2').select2()
$(document).on('page:load', ->
  offcanvas()
  $('.s2').select2()
)
Turbolinks.enableTransitionCache();

