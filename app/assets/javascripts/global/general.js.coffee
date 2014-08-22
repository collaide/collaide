offcanvas = () ->
  canvas = false
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
        offPanel.hide()
        offPanel.show('slow')
  )
  $(document).on('click', '#header-sign-in-button', (e)->
    if(canvas != 'sign-in')
      canvas = 'sign-in'
      offPanel = $('aside.right-off-canvas-menu')
      newCanvasContent = $('#get-header-sign-in-panel').html()
      offPanel.css('background-color', '#F6F6F7')
      offPanel.empty()
      offPanel.html(newCanvasContent)
      if isCanvasOpen()
        stop(e)
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

# Empêche qu'une requête soit effectuée pour afficher les notifications quand le pannau se ferme
userPanel = () ->
  $('#user-panel-user-notifications').click (e)->
    if $('[data-offcanvas]').hasClass('move-right')
      stop(e)
      $('[data-offcanvas]').removeClass('move-right')

stop = (event) ->
  event.stopImmediatePropagation()
  event.preventDefault()
$ ->
  # enable select2 js
  offcanvas()
  userPanel()
  $('.s2').select2()
$(document).on('page:load', ->
  offcanvas()
  userPanel()
  $('.s2').select2()
)
Turbolinks.enableTransitionCache();