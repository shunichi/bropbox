$(document).ready ->
  ajaxPost = (url)->
    $.ajax
      url: url
      type: "POST"
      dataType: "json"
      data: {
        id: $("#js-tree").data("source-id")
        destination_id: $("#js-tree").data("destination-id")
      }
      success: (response)->
        console.log(response)
        if (response.errors.length > 0)
          errorMessageDiv = $("[data-id=modal-alert-danger]")
          errorMessageList = "<ul>"
          for msg, i in response.errors
            errorMessageList += "<li>#{msg.message}</li>"
          errorMessageList += "</ul>"
          errorMessageDiv.html(errorMessageList)
          errorMessageDiv.removeClass("hide")
        else
          location.reload()
        return

  $("[data-role=directory-command]").on "click", ->
    $("#js-tree").data("source-id", $(this).data("id"))

  $("[data-id=dir-move-btn]").on "click", ->
    ajaxPost($(this).data("url"))

  $("[data-id=dir-copy-btn]").on "click", ->
    ajaxPost($(this).data("url"))
return
