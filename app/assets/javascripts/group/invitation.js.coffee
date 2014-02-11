$ ->
  splitInvitation = (value) ->
    value.split('/,\s*/')
  extractLast = (term) ->
    splitInvitation(term).pop()
  $('#invitation_users')
  .bind 'keydown', (event) ->
    if event.keyCode == $.ui.keyCode.TAB and $(this).data('ui-autocomplete').menu.active
      event.preventDefault()
  .autocomplete({
      source: (request, response) ->
        $.getJSON('/users/search', {
          term: extractLast(request.term)
        }, response)
      search: ->
        term = extractLast(this.value)
        return false if term.length < 2
    })