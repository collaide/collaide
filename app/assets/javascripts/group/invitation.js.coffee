$ ->
  splitInvitation = (value) ->
    value.split( /,\s*/ )
  extractLast = (term) ->
    splitInvitation(term).pop()
  $('#group_invitation_users')
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
      focus: ->
        false
      select: (event, ui) ->
        terms = splitInvitation(this.value)
        terms.pop()
        terms.push(ui.item.value)
        terms.push("")
        this.value = terms.join(', ')
        $("<option value=\"#{ui.item.id}\" selected=\"selected\">#{ui.item.value}</option>").appendTo('#group_invitation_users_ids')
        false
    })