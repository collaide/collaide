# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
s2 = ->
  $('.s2_users_select').select2({
    minimumInputLength: 2
    placeholder: $('#placeholder_user_ids').text()
    multiple: true
    ajax: #instead of writing the function to execute the request we use Select2's convenient helper
      url: '/users/search'
      dataType: 'json'
      data: (term, page) ->
        term: term
        #limit: 10
        page: page
      results: (data, page) ->
        results: data
    formatResult: (record) ->
      record.value
    formatSelection: (record) ->
      record.value
  });

$ ->
  s2()
$(document).on('page:load', ->
  s2()
)
