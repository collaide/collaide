# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# le js ne s'exécute plus, puiqu'il y une errure avec split!!! corrigé tout ira bien. y compris la pagiantion

if history && history.pushState
  $('#print-criter').hide()
  $(window).on 'hashchange', ->
    alert location.href

  $ ->
    $('#paginate li a').on 'click', ->
      history.pushState '', null, this.href

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
      url = $('#url_for_ajax').val()
      ajaxUrl = ''
      makeUrl(domain, 'domain')
      makeUrl(type, 'type')
      makeUrl(realized_before, 'created_at')
      ajaxUrl += "order_by=#{order_by}" if order_by != '0'
      url+='?'+ajaxUrl

      #history.pushState('', null, url) if realized_before or order_by != '0'
      $.get url, (data, status) ->
        $(".pagination > li").each ->
          href = $(this).children('a').attr('href').split('?')[0]
          $(this).children('a').attr('href', href+'?'+ajaxUrl) if  href!= '#'
        if realized_before or order_by != '0'
          seoUrl = ''
          seoUrl = "created_at=#{realized_before}" if realized_before
          seoUrl += '&' if realized_before and order_by != '0'
          seoUrl += "order_by=#{order_by}" if order_by != '0'
#          alert $('#url_for_order').val()
#          history.pushState('', null, $('#url_for_order').val()+'?'+seoUrl)
      , 'script'

    makeUrl = (attr, name) ->
      ajaxUrl += "#{name}=#{attr}" if attr
      addAnd(attr)
    makeSEOUrl = () ->
      seoUrl = ''
      seoUrl += (domain+'+') if domain
      seoUrl += (type+'+') if type
      seoUrl += (realized_before+'+') if realized_before
      seoUrl += (order_by+'+') if order_by != '0'
      seoUrl = seoUrl.slice(0, -1) if seoUrl != ''
      seoUrl

    addAnd = (attr) ->
      ajaxUrl += '&' if attr and ajaxUrl != ''

$('#more_infos').click ->
  $('#more_details').toggle('slow')

$ ->
  $('#display-search').click ->
    $('#form_to_hide').toggleClass('hide-for-small');


