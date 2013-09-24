# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#more_details').click ->
  $('#form_to_hide').toggle 'slow'

$("#book_isbn").click -> $('#book_title_to_hide').hide 'slow'

addErrorToIsbn = () ->
  $('.advertisement_sale_book_book_isbn_13').addClass('error')
  $('#book_isbn').after("<small class='small_book_isbn_error'>"+$('#ajax_book_isbn_error').val()+". "+$('#ajax_book_isbn_other_solution').val()+"</small>");

disabledInput = (input) ->
  $(input).addClass('disabled')
  $(input).attr("disabled", "disabled")


initializeIsbn = () ->
  $(".small_book_isbn_error").remove()
  $('.advertisement_sale_book_book_isbn_13').removeClass('error')
  $('#book_title').removeClass('disabled')
  $('#book_authors').removeClass('disabled')
  $('#book_title').removeAttr("disabled")
  $('#book_authors').removeAttr("disabled")
  $('#book_title').val("")
  $('#book_authors').val("")

  #Pour la page de correction
#$(document).ready ->
#  #si on a deja soumis le form
#  if $('#book_isbn').val() != '' &&  $('#book_title').val() != '' && $('#book_authors').val() != ''
#    disabledInput('#book_title')
#    disabledInput('#book_authors')

$('#book_isbn').blur ->
  initializeIsbn()
  isbn = $('#book_isbn').val()
  #if isbn.length==10||isbn.length==13
  if isbn.length > 0
    $.getJSON(
      $('#ajax_path').val(),
      {isbn: isbn},
      (data, textStatus, jqXHR) ->
        if (data.title) # On a trouvé un titre
          $('#book_title').val(data.title)
          disabledInput('#book_title')
          if (data.authors)
            $('#book_authors').val(data.authors)
            disabledInput('#book_authors')
          $('#book_title_to_hide').show 'slow'
        else
          # Afficher qu'on n'a pas trouvé le ISBN en rouge
          addErrorToIsbn()
          $('#book_title_to_hide').show 'slow'
    )
#  else if isbn.length > 0 # Il a entré un ISBN
#    # Afficher qu'on n'a pas trouvé le ISBN en rouge
#    addErrorToIsbn()
#    $('#book_title_to_hide').show 'slow'
  else
    $('#book_isbn').after("<small class='small_book_isbn_error'>"+$('#ajax_book_isbn_other_solution').val()+"</small>");
    $('#book_title_to_hide').show 'slow'

# ACHAT D UN LIVRE

initializeBuy = () ->
  $('#buy_book').find('.buy_book_title').empty();
  $('#buy_book').find('.buy_book_content').empty();
  $('#buy_book').find('textarea').empty();
  $('#buy_book').find('#message_sending_user_ids').empty();
  $('#buy_book').find('#message_sending_subject').empty();


$('.button_buy_book').click ->
  initializeBuy()
  sale_book_id = $(this).attr('id');
  # Vire ce qui est inutil, récupère l'id du doc cliqué.
  sale_book_id = sale_book_id.replace('button_buy_book_','');
  # Ok, on a l'id de la vente
  find_sale_book = '.sale_book_id_'.concat(sale_book_id)
  #$('.sale_book_id_37').hide 'slow'
#  title = $(find_sale_book).find('.sale_book_title').text()
#  price = $(find_sale_book).find('.sale_book_price').text()
#  user = $(find_sale_book).find('.sale_book_user_link').text()
  title_text = $(find_sale_book).find('.sale_book_text_title').html()
  content_text = $(find_sale_book).find('.sale_book_text_content').html()
  content_textarea = $(find_sale_book).find('.sale_book_textarea_content').text()
  content_subject = $(find_sale_book).find('.sale_book_subject_content').text()
  user_id = $(find_sale_book).find('.sale_book_user_id').text()
  $('#buy_book').find('.buy_book_title').html(title_text);
  $('#buy_book').find('.buy_book_content').html(content_text);
  $('#buy_book').find('textarea').val(content_textarea);
  $('#buy_book').find('#message_sending_user_ids').val(user_id);
  $('#buy_book').find('#message_sending_subject').val(content_subject);

  $(this).find('span').text()