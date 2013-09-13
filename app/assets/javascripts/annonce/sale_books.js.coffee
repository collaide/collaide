# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#more_details').click ->
  $('#form_to_hide').toggle 'slow'

$('#book_isbn').blur ->
  isbn = $('#book_isbn').val()
  if isbn.length==10||isbn.length==13
    $.getJSON(
      $('#ajax_path').val(),
      {isbn: isbn},
      (data, textStatus, jqXHR) ->
        if (data.title) # On a trouvé un titre
          $('#book_title').val(data.title)
          $('#book_title_to_hide').show 'slow'
        else
          # Afficher qu'on n'a pas trouvé le ISBN en rouge
    )
  else
    $('#book_title_to_hide').hide 'slow'
    # Afficher qu'on n'a pas trouvé le ISBN en rouge
