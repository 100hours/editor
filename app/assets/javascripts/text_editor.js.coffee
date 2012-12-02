# TODO : Rewrite this using some proper design patterns

class Editor
  dirty: false
  snapshot:
    body: false
    title: false

  constructor: ->
    @throttledSave = $.throttle(500, @_save)
    @takeSnapshot()

  takeSnapshot: ->
    @snapshot.body = @currentBody()
    @snapshot.title = @currentTitle()

  currentBody: ->
    $('#redactor').getCode()

  currentTitle: ->
    $('#document_title').val()

  textChanged: ->
    (@snapshot.body != @currentBody()) or (@snapshot.title != @currentTitle())

  update: ->
    if (@textChanged() and not @dirty)
      @dirty = true
      @throttledSave() # TODO: Throttle this

  _save: ->
    console.log '_save'
    @takeSnapshot()
    form = $('form')
    $.ajax
      type: 'POST'
      url: form.attr('action')
      data: form.serialize()
      dataType: 'json'
      success: (response) =>
        @dirty = false

App.register 'documents/edit', (data) ->
  $('#redactor').redactor()

  editor = new Editor

  setInterval ->
    editor.update()
  , 500
