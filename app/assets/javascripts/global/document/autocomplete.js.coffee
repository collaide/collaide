autocomplete = () ->
  $('#search').autocomplete({
      source: $('#auto_complete_url').val(),
      minLength: 2,
      select: (event, ui) ->
          $('#go-search').click()
  })

$ ->
  autocomplete()
$(document).on('page:load', ->
  autocomplete()
)