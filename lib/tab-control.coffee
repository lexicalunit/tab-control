{CompositeDisposable} = require 'atom'
TabControlStatus = require './tab-control-status'

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

  activate: =>
    @status = new TabControlStatus
    @subs = new CompositeDisposable
    @subs.add atom.commands.add 'atom-workspace', 'tab-control:show', @show
    @subs.add atom.workspace.observeTextEditors (editor) =>
      disposable = editor.onDidChangeGrammar => @status?.update()
      editor.onDidDestroy -> disposable.dispose()

  consumeStatusBar: (statusBar) =>
    @status.attach statusBar

  deactivate: =>
    @subs?.dispose()
    @subs = null
    @dialog?.destroy()
    @dialog = null
    @status?.destroy()
    @status = null

  show: =>
    unless @dialog?
      TabControlDialog = require './tab-control-dialog'
      @dialog = new TabControlDialog @status
    @dialog.toggle()

module.exports = new TabControl
