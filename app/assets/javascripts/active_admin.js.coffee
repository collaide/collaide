# Voir ici http://stackoverflow.com/questions/16844411/rails-active-admin-deployment-couldnt-find-file-jquery-ui
#= require jquery
#= require jquery_ujs
#= require jquery-ui/core
#= require jquery-ui/widget
#= require jquery-ui/datepicker
#= require active_admin/application

$(document).on('click', '.mjs-nestedSortable-branch', (e) ->
  e.preventDefault()
  $(this).children('ol').toggle('slow$')
)