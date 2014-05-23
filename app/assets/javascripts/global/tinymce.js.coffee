tiny_mce = () ->
  tinymce_init = (textarea_id) -> tinyMCE.init({
    selector: "textarea#" + textarea_id,
    auto_focus: textarea_id,
    language: "fr_FR",
    plugins: "autoresize advlist autolink autosave link image lists print hr anchor,searchreplace wordcount code fullscreen,table emoticons sh4tinymce",
    #toolbar1: " fullscreen | undo redo | searchreplace | bold italic underline strikethrough subscript superscript | blockquote sh4tinymce | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link unlink image media | table | charmap emoticons | styleselect | print code",
    toolbar1: "fullscreen | undo redo | searchreplace | bold italic underline strikethrough subscript superscript | blockquote sh4tinymce | bullist numlist | link unlink image media | table | charmap emoticons | styleselect | print code headers",
    menubar: false,
    statusbar: false,
    toolbar_items_size: "small",
    browser_spellcheck: true,
    extended_valid_elements: "pre[class|name]",
    remove_linebreaks: false,
    formats: {
#    alignleft : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'left'},
#    aligncenter : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'center'},
#    alignright : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'right'},
#    alignfull : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'full'},
    #italic : {inline : 'i'},
    #underline : {inline : 'u'},
    #strikethrough : {inline : 'del'},
    }
  })
  $('textarea.tinymce').click ->
    tinymce_init($(this).attr('id'))

$ ->
  tiny_mce()
$(document).on('page:load', ->
  tiny_mce()
)


