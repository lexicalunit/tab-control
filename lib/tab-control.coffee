# Public: Package for controling and monitoring tab settings.
class TabControl
  config:
    autoSaveChanges:
      type: 'boolean'
      default: false
    displayInStatusBar:
      type: 'boolean'
      default: true

  dialog: null
  status: null
  subs: null

  # Public: Creates status bar indicator and sets up commands for control dialog.
  activate: ->
    # performance optimization: require only after activation
    {CompositeDisposable} = require 'atom'
    TabControlStatus = require './tab-control-status'
    @subs = new CompositeDisposable
    @status = new TabControlStatus
    @subs.add atom.commands.add 'atom-workspace', 'tab-control:show', @show
    @subs.add atom.workspace.observeTextEditors (editor) =>
      disposable = editor.onDidChangeGrammar => @status?.update()
      editor.onDidDestroy -> disposable.dispose()

  # Public: Removes status bar indicator and destroy control dialog.
  deactivate: ->
    @subs?.dispose()
    @subs = null
    @dialog?.destroy()
    @dialog = null
    @status?.destroy()
    @status = null

  # Public: Shows control dialog.
  show: => # fat arrow required
    unless @dialog?
      TabControlDialog = require './tab-control-dialog'
      @dialog = new TabControlDialog @status
    @dialog.toggle()

  # Private: Attaches status bar indicator to workspace status bar.
  consumeStatusBar: (statusBar) ->
    @status.attach statusBar

module.exports = new TabControl
