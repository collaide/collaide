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
      if(request and request.responseJSON and (errors = request.responseJSON.errors))
        method = e.target.id.substring(5)
        msg = errors[method]
        if(msg)
          addErrorToField(method, msg)
        else
          if($("aside #user_#{method}").hasClass('invalid'))
            $("aside #user_#{method}").removeClass('invalid')
            $("aside #user_#{method}").next('small').remove()
  })
) .
on('submit', '#new_user', (e)->
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
)

userData = ->
  user = {user:{email: getVale('email'),name: getVale('name'),password: getVale('password'),password_confirmation: getVale('password_confirmation')}}
  user

addErrorToField = (selector, msg)->
  selector = "aside #user_#{selector}"
  console.log selector
  error_elem = $(selector).next('small')
  $(selector).addClass('invalid')
  if(error_elem.length != 0)
    error_elem.html(msg)
  else
    $(selector).parent().append("<small class=\"error\">#{msg}<small/>")
getVale = (selector)->
  $("aside #user_#{selector}").val()