# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$('#paginate li a').on 'click', ->
  history.pushState('', null, this.href)
$ ->
  type = false
  domain = false
  order_by = $('#order').val()
  realized_before = false
  ajaxUrl = ''
  $('#type').change ->
    type = $('#type').val()
    doAjax()
  $('#domains').change ->
    domain = $('#domains').val()
    doAjax()
  $('#order').change ->
    order_by = $('#order').val()
    doAjax()
  $('#datepicker').change ->
    realized_before = $('#datepicker').val()
    doAjax()

  doAjax = () ->
    url = $('#url_for_order').val()
    ajaxUrl = ''
    makeUrl(domain, 'domain')
    makeUrl(type, 'type')
    makeUrl(realized_before, 'created_at')
    ajaxUrl += "order_by=#{order_by}"
    url+='?'+ajaxUrl

    history.pushState('', null, url)

    $.get url, (data, status) ->
      $(".pagination > li").each ->
      href = $(this).children('a').attr('href').split('?')[0]
      $(this).children('a').attr('href', href+'?'+ajaxUrl) if  href!= '#'
    , 'script'

  makeUrl = (attr, name) ->
    ajaxUrl += "#{name}=#{attr}" if attr
    addAnd(attr)

  addAnd = (attr) ->
    ajaxUrl += '&' if attr and ajaxUrl != ''


