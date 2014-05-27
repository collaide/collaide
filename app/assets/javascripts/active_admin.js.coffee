#= require active_admin/base

$(document).on('click', '.mjs-nestedSortable-branch', (e) ->
  e.preventDefault()
  $(this).children('ol').toggle('slow')
)