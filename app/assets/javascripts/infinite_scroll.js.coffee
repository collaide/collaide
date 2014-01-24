$ ->
  loading = false
  nearBottomOfPage = () ->
    $(window).scrollTop() > $(document).height() - $(window).height() - 200;
  getNextPage = () ->
    $('#paginate ul li a[rel=next]').attr('href')
  isFinished = () ->
    (getNextPage() == undefined) ? true : false
  $(window).scroll ->
    return if(loading)
    url = getNextPage()
    if(nearBottomOfPage() && !isFinished())
      $.ajax({
        url: url,
        type: 'get',
        dataType: 'script',
        success: () ->
          loading = false
      })