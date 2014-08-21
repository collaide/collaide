#infinite_scroll = ()->
#  loading = false
#  nearBottomOfPage = () ->
#    $(window).scrollTop() > $(document).height() - $(window).height() - 200;
#  getNextPage = () ->
#    $('#paginate ul li a[rel=next]').attr('href')
#  isFinished = () ->
#    (getNextPage() == undefined) ? true : false
#  $(window).scroll ->
#    return if(loading)
#    url = getNextPage()
#    if(nearBottomOfPage() && !isFinished())
#      $.ajax({
#        url: url,
#        type: 'get',
#        dataType: 'script',
#        success: () ->
#          loading = false
#      })
#$ ->
#  infinite_scroll()
#$(document).on('page:load', ->
#  infinite_scroll()
#)

#TODO: translate

infinite = ->
  $("#infinite-scroll .page").infinitescroll
    navSelector: "ul.pagination"
    nextSelector: "ul.pagination a[rel=next]"
    itemSelector: "#infinite-scroll .items"
    loading: {
      finishedMsg: "<em>Il n'y a pas d'autres eléments à afficher</em>",
      msgText: "<em>Chargement des prochains eléments</em>",
    }
$(document).ready ->
  infinite()
$(document).on('page:load', ->
  infinite()
)
