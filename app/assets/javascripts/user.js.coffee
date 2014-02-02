$ ->
  $('#change-password').click ->
    $('#hidden-password').show('slow')
    $('#general-infos').hide('slow')
    $(this).removeClass('secondary')
    $('#general-change').addClass('secondary') unless $('#general-change').hasClass('secondary')
  $('#general-change').click ->
    $('#hidden-password').hide('slow')
    $('#general-infos').show('slow')
    $(this).removeClass('secondary')
    $('#change-password').addClass('secondary') unless $('#change-password').hasClass('secondary')