# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    table = $("table tbody")
    table.empty()
    for doc in data.doc
      table.append "<tr>
                        <td><a href='"+data.urls[doc.id]+"'>"+doc.title+"</a></td>
                        <td>"+doc.description+"</td>
                        <td>"+doc.language+"</td>
                        <td>"+doc.study_level.name+"</td>
                        <td>"+doc.document_type.name+"</td>
                        <td>"+data.dates[doc.id]+"</td>
                        <td>"+data.domains[doc.id]+"</td>
                    </tr>"
