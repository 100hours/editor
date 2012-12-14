# TODO : Rewrite this using some proper design patterns

class Editor
  dirty: false
  snapshot:
    body: false
    title: false

  constructor: ->
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

  countWords: (text) ->
    $('#redactor').getText().match(/\w+/g).length;

  updateWordCount: ->
    $('#document_word_count').val(@countWords(@snapshot.body))

  update: ->
    if (@textChanged() and not @dirty)
      @dirty = true
      @takeSnapshot()
      @updateWordCount()
      @_save()

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
  $('#redactor').redactor()

  editor = new Editor

  setInterval ->
    editor.update()
  , 500
