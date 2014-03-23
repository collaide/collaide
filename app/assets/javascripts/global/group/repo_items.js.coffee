class window.RepoItem
  @start: (index) ->
    $.getJSON(document.URL, (data) ->
      repo_items = data.repo_items
      repo_items = data.children if(index)
      $('#panel-items').html(JST['global/group/templates/index']({repo_items: repo_items}))
      Utils.loaded()
    )
class Utils
  @type
  @flash: (key, msg) ->
    $('#flash-msg').html('')
    $('#flash-msg').
    append(JST['global/group/templates/flash']({text: msg, key: key}))
  @loaded: () ->
#    if type == @type
#      console.log 'stop'
#      return
#    else
#      console.log type
#      @type = type
    $.event.trigger({
      type: 'repo_items:loaded'
    })
  @add_item: (item) ->
    $('#items').prepend(JST['global/group/templates/item']({item: item}))

$(document).on('repo_items:loaded', () ->
  console.log 'loaded'

  $('a[data-method]').on('ajax:success', (e, data, status, xhr) ->
    Utils.flash('notice', data.notice)
    $(this).parents('.an-item').remove()
  ).on('ajax:error', (data, xhr, status, e) ->
    Utils.flash('alert', xhr.responseJSON.repo_items)
  )
)
$ ->
  $('#form_folder').on('ajax:success', (e, data, status, xhr) ->
    Utils.add_item(data)
    $('#repo_folder_name').val('')
    Utils.loaded()
  ).on('ajax:error', (data, xhr, status, e) ->
    $('#flash-msg').html('')
    Utils.flash('alert', msg) for msg in xhr.responseJSON.repo_items
  )
  $('#repo_file_file').on('change', (e) ->
    $('#file-uploader').ajaxSubmit({
      beforeSubmit: (a, f, o) ->
        o.dataType = 'json'
      complete: (XMLHttpRequest, status) ->
        alert('salut')
    })
  )
#  $('#file-uploader').on('ajax:success', (e, data, status, xhr) ->
#    Utils.add_item(data)
#  )
