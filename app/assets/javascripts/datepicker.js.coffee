$ ->
  $('.datepicker').datepicker({
    changeMonth: true,
    changeYear: true
  })
  $('.datepicker-form').datepicker({
    changeMonth: true,
    changeYear: true,
    altField: "#populate-datepicker",
    altFormat: "yy-mm-dd",
    dateFormat: "d M yy"
  }, $.datepicker.regional[ "fr" ])
  $( ".datepicker-form" ).datepicker( "setDate",  new Date($('#populate-datepicker').val())) unless $('#populate-datepicker').val() == ''