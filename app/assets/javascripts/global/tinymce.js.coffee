tinymce_init = (textarea_id) -> tinyMCE.init({
  selector: "textarea#" + textarea_id,
  auto_focus: textarea_id,
  language: "fr_FR",
  plugins: "advlist autolink autosave link image lists print hr anchor,searchreplace wordcount code fullscreen,table emoticons sh4tinymce",
  toolbar1: " fullscreen | undo redo | searchreplace | bold italic underline strikethrough subscript superscript | blockquote sh4tinymce | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link unlink image media | table | charmap emoticons | styleselect | print code",
  menubar: false,
  toolbar_items_size: "small",
  browser_spellcheck: true,
  extended_valid_elements: "pre[class|name]",
  remove_linebreaks: false
})

$ ->
  $('textarea').click ->
    tinymce_init($(this).attr('id'))

