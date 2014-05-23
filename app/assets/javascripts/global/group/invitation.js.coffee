#splitInvitation = (value) ->
#  value.split( /,\s*/ )
#extractLast = (term) ->
#  splitInvitation(term).pop()
#invitation = ->
#  $('#group_do_invitation_email_list')
#  .bind 'keydown', (event) ->
#    if event.keyCode == $.ui.keyCode.TAB and $(this).data('ui-autocomplete').menu.active
#      event.preventDefault()
#  .autocomplete({
#      source: (request, response) ->
#        $.getJSON('/users/search', {
#          term: extractLast(request.term)
#        }, response)
#      search: ->
#        term = extractLast(this.value)
#        return false if term.length < 2
#      focus: ->
#        false
#      select: (event, ui) ->
#        terms = splitInvitation(this.value)
#        terms.pop()
#        terms.push(ui.item.value)
#        terms.push("")
#        this.value = terms.join(', ')
#        $("<option value=\"#{ui.item.id}\" selected=\"selected\">#{ui.item.value}</option>").appendTo('#group_do_invitation_users_id')
#        false
#    })


invitation  = () ->
  lastResult = []
  format = (record) ->
    image_txt = ''
    text = ''
    if record.path
      text = "<a href='#{record.path}'>#{record.text}</a>"
    else
      text = record.text
    if record.img
      image = record.img
      image_txt = "<img src='#{image}' width='20' height='20'/>"
    image_txt + record.text
  $('#group_do_invitation_users_id').select2({
    minimumInputLength: 2
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
          results: []
        else
          lastResult = []
          results: []
    formatResult: (record) ->
      format(record)
    formatSelection: (record) ->
      format(record)
    createSearchChoice: (term) ->
      if(lastResult.length != 0)
        id: lastResult[0].id, text: lastResult[0].name, img: lastResult[0].img, path: lastResult[0].path
      else
        id: term, text: term + " (non membre)"
    initSelection: (element, callback) ->
      invitations_list = element.val().split(',')
      datas = []
      jsonNeeded = false
      for invitation_id in invitations_list
        if isNaN(invitation_id)
          datas.push({id: invitation_id, text: invitation_id + ' (non membre)'})
        else
          $.ajax('/users/search.json?id='+invitation_id).done((data) ->
            if data.length > 0
              jsonNeede = true
              data[0].text = data[0].name
              datas.push(data[0])
              $.event.trigger({type:'init:done'})
          )
      if jsonNeeded
        $(document).on('init:done', ->
          callback(datas)
        )
      else callback(datas)
  });

$ ->
  invitation()
$(document).on('page:load', ->
  invitation()
)
