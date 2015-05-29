{CompositeDisposable} = require 'atom'
TabControlStatus = require './tab-control-status'

# FIXME: For some insane reason, having this as an instance variable
# of TabControl breaks everything in utterly baffeling ways. So
# for now I guess it has to be a package level global. To make matters
# worse, TabControl.hook is *also* required to make unit tests work.
status = null

class TabControl
  config:
    displayInStatusBar:
      type: 'boolean'
      default: false
    autoSaveChanges:
      type: 'boolean'
      default: false

  dialog: null
  subs: null
  hook: null

  activate: ->
    @hook = status = new TabControlStatus
    @subs = new CompositeDisposable
    @subs.add atom.commands.add 'atom-workspace', 'tab-control:show', @show
    @subs.add atom.workspace.observeTextEditors (editor) ->
      disposable = editor.onDidChangeGrammar -> status?.update()
      editor.onDidDestroy -> disposable.dispose()

  consumeStatusBar: (statusBar) ->
    status.attach statusBar

  deactivate: ->
    @subs?.dispose()
    @subs = null
    @dialog?.destroy()
    @dialog = null
    status?.destroy()
    @hook = status = null

  show: ->
    unless @dialog?
      TabControlDialog = require './tab-control-dialog'
      @dialog = new TabControlDialog status
    @dialog.toggle()

module.exports = new TabControl
