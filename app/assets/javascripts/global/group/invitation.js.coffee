splitInvitation = (value) ->
  value.split( /,\s*/ )
extractLast = (term) ->
  splitInvitation(term).pop()
invitation = ->
  $('#group_do_invitation_email_list')
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
        $("<option value=\"#{ui.item.id}\" selected=\"selected\">#{ui.item.value}</option>").appendTo('#group_do_invitation_users_id')
        false
    })
$ ->
  invitation()
$(document).on('page:load', ->
  invitation()
)

$ ->
  lastResult = []
  $('#group_do_invitation_users_id').select2({
    minimumInputLength: 2
    placeholder: 'salut'
    multiple: true
    ajax: #instead of writing the function to execute the request we use Select2's convenient helper
      url: '/users/search'
      dataType: 'json'
      data: (term, page) ->
        term: term
        #limit: 10
        page: page
      results: (data, page) ->
        lastResult = data
        if data
          results: data
        else
          lastResult = []
          results: []
    formatResult: (record) ->
      record.value
    formatSelection: (record) ->
      record.value
    createSearchChoice: (term) ->
      if(lastResult.some((r) ->
          r.text == term
        ))
        id: term, text: termq
      else
        id: term, text: term+' (new)'
  });

  # ajax: {
  #       multiple: true,
  #       url: "/echo/json/",
  #       dataType: "json",
  #       type: "POST",
  #       data: function (term, page) {
  #           return {
  #               json: JSON.stringify({results: [{id: "foo", text:"foo"},{id:"bar", text:"bar"}]}),
  #               q: term
  #           };
  #       },
  #       results: function (data, page) {
  #           lastResults = data.results;
  #           return data;
  #       }
  #   },
  #   createSearchChoice: function (term) {
  #       if(lastResults.some(function(r) { return r.text == term })) {
  #           return { id: term, text: term };
  #       }
  #       else {
  #           return { id: term, text: term + " (new)" };
  #       }
  #   }
