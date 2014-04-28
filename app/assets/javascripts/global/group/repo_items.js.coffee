class window.RepoItem
  @is_started = false
  @is_first_time = true
  @session_cleared = false
  @start: (index) ->
    $.getJSON("#{document.URL}.json", (data) ->
      repo_items = data.repo_items
      repo_items = data.children if(index)
      $('#panel-items').html(JST['global/group/templates/index']({repo_items: repo_items}))
    )
    @is_started = true
class Utils
  @push: (title, url) ->
    Session.set(document.location, true) # pour le retour arrière
    Session.set(url, true) # pour le retour avant
    window.history.pushState(null, title, url)
  @is_pushed: (url)->
     return Session.get(url)
  @flash: (key, msg) ->
    $('#flash-msg').html('')
    $('#flash-msg').append(JST['global/group/templates/flash']({text: msg, key: key}))
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
class PressPaper
  @remove_from: (element)->
    $(element).parents('.press-paper-line').remove()
    if $('#press-paper-content').children().size()==0
      $('#press-paper').hide()

$ ->
  #========================================================================
  #=============== retour arrière =========================================
  window.onpopstate = (event) ->
    if RepoItem.is_started
      if RepoItem.is_first_time
        RepoItem.is_first_time = false
      else
        if Utils.is_pushed(document.location)
          $.getJSON("#{document.location}.json", (data) ->
            if data.repo_items
              repo_items = data.repo_items
            else
              repo_items = data.children
            $('.repo_item_id').val(data.id)
            $('#panel-items').html(JST['global/group/templates/index']({repo_items: repo_items}))
            $('#breadcrumb-folder').html(JST['global/group/templates/bread_crumb']({folders: data.path, root_folder: $('#root_folder').parent().html()})))
    else
      if !RepoItem.session_cleared
        Session.clear()
        RepoItem.session_cleared = true
  #========================================================================
  # -------------- clique sur un fichier ou dossier ----------------------------------
  $(document).on('ajax:success', '.item-name a', (e, data, status, xhr) ->
    $('#panel-items').html(JST['global/group/templates/index']({repo_items: data.children}))
    $('.repo_item_id').val(data.id)
    $('#breadcrumb-folder').html(JST['global/group/templates/bread_crumb']({folders: data.path, root_folder: $('#root_folder').parent().html()}))
    Utils.push("#{data.name} - #{document.title}", data.url)
  )
  # -------------- clique sur le root folder -------------------------------
  $(document).on('ajax:success', '#root_folder', (e, data, status, xhr) ->
    repo_items = data.repo_items
    $('#panel-items').html(JST['global/group/templates/index']({repo_items: repo_items}))
    $('.repo_item_id').val(null)
    $('#breadcrumb-folder').html(JST['global/group/templates/bread_crumb']({folders: null, root_folder: $('#root_folder').parent().html()}))
    Utils.push("#{document.title}", data.url)
  )
  #========================================================================
  #=============== mettre en haut =========================================
  $(document).on('click', '.move-copy', () ->
    $('#press-paper-content').append(JST['global/group/templates/press_paper']({
      link: $(this).parents('.an-item').find('.item-name'),
      copy: $(this).attr('data-copy'),
      move: $(this).attr('data-move'),
      repo_id: $(this).parents('.an-item').attr('id')}))
    if ($('#press-paper').hasClass('hide'))
      $('#press-paper').show()
    $(this)
    .addClass('disabled')
    .addClass('move-copy-disabled')
    .removeClass('move-copy')
    .text('Ajouté en haut')
  )
  #========================================================================
  #=============== retirer du presse-papier ===============================
  $(document).on('click', '.cancel-press-paper', () ->
    $('#' + $(this).parents('.press-paper-line').attr('id').split('_')[1])
    .find('.move-copy-disabled')
    .removeClass('disabled')
    .addClass('move-copy')
    .removeClass('move-copy-disabled')
    .text('Ajouter en haut')
    PressPaper.remove_from(this)
  )
  #========================================================================
  #=============== copier =================================================
  $(document).on('ajax:success', '.copy-form', (e, data, status, xhr) ->
    Utils.add_item(data)
  ).on('ajax:error', '.copy-form', (data, xhr, status, e) ->
    Utils.flash('alert', msg) for msg in xhr.responseJSON.copy
  )
  #========================================================================
  #=============== déplacer =================================================
  $(document).on('ajax:success', '.move-form', (e, data, status, xhr) ->
    Utils.add_item(data)
    PressPaper.remove_from(this)
  ).on('ajax:error', '.move-form', (data, xhr, status, e) ->
    Utils.flash('alert', msg) for msg in xhr.responseJSON.move
  )
  #========================================================================
  #=============== renommer ===============================================
  $(document).on('click', '.rename-item', ()->
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
  #========================================================================
  #=============== supprimer ==============================================
  $(document).on('ajax:success', 'a[data-method]', (e, data, status, xhr) ->
      Utils.flash('notice', data.notice)
      PressPaper.remove_from($('#press-paper_' + $(this).parents('.an-item').attr('id')).children())
      $(this).parents('.an-item').remove()
  ).on('ajax:error', (data, xhr, status, e) ->
    Utils.flash('alert', xhr.responseJSON.repo_items)
  )
  #========================================================================
  #=============== création de dossier ====================================
  $('#form_folder').on('ajax:success', (e, data, status, xhr) ->
    Utils.add_item(data)
    $('#repo_folder_name').val('')
  ).on('ajax:error', (data, xhr, status, e) ->
    Utils.flash('alert', msg) for msg in xhr.responseJSON.repo_items
  )

  #========================================================================
  #=============== déposer un fichier =====================================
  $('#repo_file_file').on('change', (e) ->
    $('#all-progress-bar').append(JST['global/group/templates/progress_bar']({text: "Déchargement du fichier '#{e.target.files[0].name}'"}))
    elem = $('.progress-bar').last()

    upload = $('#file-uploader').ajaxSubmit({
      beforeSubmit: (a, f, o) ->
        o.dataType = 'json'
      clearForm: true,
      resetForm: true,
      error: (xhr, status) ->
        if xhr.responseJSON
          Utils.flash('alert', msg) for msg in xhr.responseJSON.repo_items
        else
          Utils.flash('alert', 'Impossible de déposer ce fichier')
      success: (xhr, status) ->
        Utils.add_item(xhr)
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
#========================================================================
#=============== fermer message flash ===================================
$(document).on('click', '.alert-box .close', () ->
  $(this).parent().remove()
)
