$(document).ready ->
  indentStyle = ->
    $(".tree-item").each ->
      $(this).css("padding-left", $(this).data("depth")+"em")

  indentStyle()

  $(document).on "click", ".tree-item", ->
    $("#js-tree").data("destination-id", $(this).data("id"))
    $(".tree-item").removeClass("tree-item--selected")
    $(this).addClass("tree-item--selected")
    return false if $(this).hasClass("tree-item--children-rendered")
    $(this).addClass("tree-item--children-rendered")
    $.ajax
      url: $("#js-tree").data("url")
      type: "GET"
      dataType: 'html'
      data: {
        id: $(this).data("id")
      }
      success : (response)->
        if (response.length > 0)
          $(".tree-item--selected").after(response)
          indentStyle()
    return false
return