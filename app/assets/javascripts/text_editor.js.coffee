# TODO : Rewrite this using some proper design patterns

App.editor =
  dirty: false

  update: ->
    console.log 'update'
    @dirty = true
    @save() # TODO: Throttle this

  save: ->
    console.log 'save'
    form = $('form')
    $.ajax
      type: 'POST'
      url: form.attr('action')
      data: form.serialize()
      dataType: 'json'
      success: (response) =>
        @dirty = false

$ ->
  $('#redactor').redactor()

  $('form').keyup ->
    App.editor.update()
