$(document).on('blur', '.validate-form', (e)->
  $.ajax({
    type: 'POST',
    url: '/api/users/valid',
    data: userData(),
    success: ()->
      invalid = $('.invalid')
      console.log invalid
      console.log invalid.next('small')
      invalid.removeClass('invalid')
      invalid.next('small').remove()
    error: (request, status, error)->
      console.log 'lhasjdlahsvd'
      if(request and request.responseJSON and (errors = request.responseJSON.errors))
        method = e.target.id.substring(22)
        # TODO récuper seulement le nom (email, name, etc)
        msg = errors[method]
        console.log method
        console.log errors
        if(msg)
          addErrorToField(method, msg)
        else
          if($("aside #user_#{method}").hasClass('invalid'))
            $("aside #user_#{method}").removeClass('invalid')
            $("aside #user_#{method}").next('small').remove()
  })
) .
on('submit', '#offcanvas_new_user', (e)->
  e.preventDefault()
  $.ajax({
    type: 'POST',
    url: '/api/users/valid',
    data: userData(),
    success: ->
      e.target.submit()
    error: (request, status, error) ->
      if(request and request.responseJSON and (errors = request.responseJSON.errors))
        $.each(errors, (key, value)->
          addErrorToField(key, value)
        )
      else
        e.target.submit()
  })
).on('submit', '#offcanvas_sign_in', (e)->
  e.preventDefault()
  $.ajax({
    accepts: 'json'
    dataType: 'json'
    type: 'POST',
    url: '/api/auth_token.json',
    data: {email: getVale('email', true), password: getVale('password', true)},
  success: ->
    e.target.submit()
  error: (request, status, error) ->
    if(request and request.responseJSON and (errorMessage = request.responseJSON.error))
      $('aside #offcanvas_sign_in').prepend("
        <div data-alert class='alert-box alert'>
              #{errorMessage}
        </div>
      ")
    else
      e.target.submit()
  })
).on('click', '.offcanvas-close', (e)->
  e.preventDefault()
)

userData = ->
  user = {user:{email: getVale('email'),name: getVale('name'),password: getVale('password'),password_confirmation: getVale('password_confirmation')}}
  user

addErrorToField = (selector, msg)->
  selector = "aside #offcanvas-signup_user_#{selector}"
  console.log selector
  error_elem = $(selector).next('small')
  $(selector).addClass('invalid')
  if(error_elem.length != 0)
    error_elem.html(msg)
  else
    $(selector).parent().append("<small class=\"error\">#{msg}<small/>")
getVale = (selector, signIn = false)->
  if signIn
    return $("aside #offcanvas-connection_user_#{selector}").val()
  $("aside #offcanvas-signup_user_#{selector}").val()