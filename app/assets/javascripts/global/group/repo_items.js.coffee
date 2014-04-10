class window.RepoItem
  @start: (index) ->
    $.getJSON("#{document.URL}.json", (data) ->
      repo_items = data.repo_items
      repo_items = data.children if(index)
      $('#panel-items').html(JST['global/group/templates/index']({repo_items: repo_items}))
      Utils.loaded()
    )
class Utils
  @type
  @flash: (key, msg) ->
    $('#flash-msg').html('')
    $('#flash-msg').append(JST['global/group/templates/flash']({text: msg, key: key}))
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
  @get_auth: ->
    $('#authenticity_token').val()
  @select_range: (e, start, end) ->
    return unless e
    if(e.setSelectionRange)
      e.focus()
      e.setSelectionRange(start, end)
    else if(e.createTextRange)
      range = e.createTextRange()
      range.collapse(true)
      range.moveEnd('character', end)
      range.moveStart('character', start)
      range.select();
    else if(e.selectionStart)
      e.selectionStart = start
      e.selectionEnd = end



$(document).on('repo_items:loaded', () ->
  #renommer
  $('.rename-item').on('click', ()->
    item = $("#item-#{$(this).attr('data-id')} .item-name")
    previous_html = item.children()
    item_value =  item.find('a').text()
    item.html(JST['global/group/templates/rename']({value: item_value, auth: Utils.get_auth(), action: $(this).attr('data-href')}))
    Utils.select_range($('#form-repo-item-name'), 0, 4)
    $('.rename-item-form').on('ajax:success', (e, data) ->
      previous_html.last().text(data.name)
      item.html(previous_html)
      item_name = 'fichier'
      item_name = 'dossier' if data.is_folder
      Utils.flash('notice', "Le #{item_name} a bien été renommé")
    ).on('ajax:error', ->
      Utils.flash('alert', 'Impossible de renommer')
    )
    $('.cancel-rename').on('click', () ->
      item.html(previous_html)
    )
  )
  #supprimer
  $('a[data-method]').on('ajax:success', (e, data, status, xhr) ->
    Utils.flash('notice', data.notice)
    $(this).parents('.an-item').remove()
  ).on('ajax:error', (data, xhr, status, e) ->
    Utils.flash('alert', xhr.responseJSON.repo_items)
  )
  $('.move-copy').on('click', () ->
    $('#press-paper-content').append('<p>salut</p>')
    if ($('#press-paper').hasClass('hide'))
      $('#press-paper').show()
  )
)
$ ->
  #créer un dossier
  $('#form_folder').on('ajax:success', (e, data, status, xhr) ->
    Utils.add_item(data)
    $('#repo_folder_name').val('')
    Utils.loaded()
  ).on('ajax:error', (data, xhr, status, e) ->
    Utils.flash('alert', msg) for msg in xhr.responseJSON.repo_items
  )
  #créer un fichier
  $('#repo_file_file').on('change', (e) ->
    console.log(e.target.files[0])
    $('#all-progress-bar').append(JST['global/group/templates/progress_bar']({text: "Déchargement du fichier '#{e.target.files[0].name}'"}))
    elem = $('.progress-bar').last()

    upload = $('#file-uploader').ajaxSubmit({
      beforeSubmit: (a, f, o) ->
        o.dataType = 'json'
      clearForm: true,
      resetForm: true,
      error: (xhr, status) ->
        Utils.flash('alert', msg) for msg in xhr.responseJSON.repo_items
      success: (xhr, status) ->
        Utils.add_item(xhr)
        Utils.loaded()
      uploadProgress: (event, position, total, percent) ->
        console.log("p=#{position}, tot=#{total}, perc=#{percent}")
        elem.find('.progress-bar-meter').css('width', "#{percent}%")
        if percent == 100
          elem.html('<div class="columns small-12"><p>Traitement du fichier en cours<img src="/assets/loading.gif" width="50" height="50"/></p></div>')
      complete: () ->
        elem.remove()
        console.log('fini')
    })
    elem.find('.cancel-upload').click ->
      upload.abort()
  )
