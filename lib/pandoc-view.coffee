{$, $$$, ScrollView} = require 'atom'
path = require 'path'
pandoc = require './pandoc-command'
Stream = require 'stream'

module.exports =
class PandocView extends ScrollView
  atom.deserializers.add(this)

  @deserialize: ({filePath}) ->
    new PandocView(filepath)

  @content: ->
    @div class: 'pandoc-preview native-key-bindings', tabindex: -1

  constructor: (title, getText) ->
    super
    @title = title
    @getText = getText
    @handleEvents()
    @callback = setInterval (=> @render()), 1000

  handleEvents: ->
    @subscribe this, 'core:move-up', => @scrollUp()
    @subscribe this, 'core:move-down', => @scrollDown()

  # Returns an object that can be retrieved when package is activated
  serialize: ->
    deserializer: 'PandocView'
    filePath: @getPath()

  # Tear down any state and detach
  destroy: ->
    @unsubscribe()
    clearInterval @callback

  getTitle: ->
    "#{@title} Preview"

  showError: (msg) ->
    @html $$$ ->
      @h2 'Previewing Failed'
      @h3 msg if msg?

  getTextStream: (text) ->
    input = new Stream.Readable()
    input.push text
    input.push null
    input

  render: ->
    text = @getText()
    return if @lastText == text

    pandoc @getTextStream(text),
      (d) =>
        @html d
        @lastText = text
      (d) => @showError d
