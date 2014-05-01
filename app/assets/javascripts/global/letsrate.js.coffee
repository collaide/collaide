$.fn.raty.defaults.path = "/assets";
$.fn.raty.defaults.half_show = true;

rate = () ->
  read_only = $('.star').attr('data-read-only') == 'true'
  $('.star').raty({
    score: ->
      $(this).attr('data-rating')
    number: ->
      $(this).attr('data-star-count')
    readOnly: read_only
    click: (score, event)->
      $.post($(this).attr('data-path'), {
        score: score,
        dimension: $(this).attr('data-dimension'),
        id: $(this).attr('data-id'),
        klass: $(this).attr('data-classname')
      }, (data) ->
        if data
          $(this).off.click()
        else
          # error
      )
  })
$ ->
  rate()
$(document).on('page:load', ->
  rate()
)