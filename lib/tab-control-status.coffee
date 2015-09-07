{CompositeDisposable} = require 'atom'
{View} = require 'atom-space-pen-views'

module.exports =

# Status bar indicator showing current tab settings.
class TabControlStatus extends View
  displayInStatusBar: true
  subs: null
  tile: null

  # Private: Setup space-pen view template.
  @content: ->
    @a class: "tab-control-status inline-block"

  # Public: Creates new indicator view.
  initialize: ->
    @subs = new CompositeDisposable
    this

  # Public: destroy view, remove from status bar.
  destroy: ->
    @tile?.destroy()
    @tile = null
    @sub?.dispose()
    @sub = null

  # Public: updates view with current settings.
  update: ->
    editor = atom.workspace.getActiveTextEditor()
    if editor and @displayInStatusBar
      type = if editor.getSoftTabs() then 'Spaces' else 'Tabs'
      length = editor.getTabLength()
      @text "#{type}: #{length}"
      @show()
    else
      @hide()

  # Public: Attaches indicator view to given status bar.
  attach: (statusBar) ->
    @tile = statusBar.addRightTile
      item: this
      priority: 10
    @handleEvents()
    @update()

  # Private: Sets up event handlers for indicator.
  handleEvents: ->
    @click ->
      atom.commands.dispatch atom.views.getView(atom.workspace), 'tab-control:show'
    @subs.add atom.workspace.onDidChangeActivePaneItem =>
      @update()
    @subs.add atom.config.observe 'tab-control.displayInStatusBar', =>
      @updateConfig()

  # Private: Updates cache of atom config settings for this package.
  updateConfig: ->
    @displayInStatusBar = atom.config.get 'tab-control.displayInStatusBar'
