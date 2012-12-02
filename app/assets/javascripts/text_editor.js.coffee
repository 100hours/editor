# TODO : Rewrite this using some proper design patterns

class Editor
  dirty: false

  constructor: ->
    @throttledSave = $.throttle(500, @_save)

  update: ->
    @dirty = true
    @throttledSave() # TODO: Throttle this

  _save: ->
    console.log '_save'
    form = $('form')
    $.ajax
      type: 'POST'
      url: form.attr('action')
      data: form.serialize()
      dataType: 'json'
      success: (response) =>
        @dirty = false

App.register 'documents/edit', (data) ->
  editor = new Editor

  $('#redactor').redactor()
  setInterval ->
    editor.update()
  , 500

  #  $('form').keyup ->
  #  editor.update()
