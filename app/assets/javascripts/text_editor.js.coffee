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

  updateConnectionStatus: (text, label) ->
    $('#connection-status').attr("class", "label").html(text)
    if (label)
      $('#connection-status').addClass("label-" + label)

  update: ->
    if (@textChanged() and not @dirty)
      @dirty = true
      @takeSnapshot()
      @updateWordCount()
      @_save()

  _save: ->
    @takeSnapshot()
    form = $('form')
    @updateConnectionStatus("Saving...")
    $.ajax
      type: 'POST'
      url: form.attr('action')
      data: form.serialize()
      dataType: 'json'
      timeout: 5000
      success: (response) =>
        @updateConnectionStatus("Saved", "info")
        @dirty = false
      error: (response) ->
        @updateConnectionStatus("Failed to save", "warning")
        @dirty = false

App.register 'documents/edit', (data) ->
  $('#redactor').redactor()

  editor = new Editor

  editor.updateConnectionStatus("Ready!", "info")

  setInterval ->
    editor.update()
  , 500
