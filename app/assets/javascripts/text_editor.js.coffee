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


$ ->
  editor = new Editor

  $('#redactor').redactor()
  $('form').keyup ->
    editor.update()
