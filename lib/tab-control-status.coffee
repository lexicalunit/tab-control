{CompositeDisposable} = require 'atom'
{View} = require 'atom-space-pen-views'

module.exports =
class TabControlStatus extends View
  displayInStatusBar: true
  subs: null
  tile: null

  @content: ->
    @div class:"tab-control-status inline-block", ->

  initialize: ->
    @subs = new CompositeDisposable
    this

  attach: (statusBar) ->
    @tile = statusBar.addRightTile
      item: this
      priority: 10
    @handleEvents()
    @update()

  handleEvents: ->
    @click ->
      atom.commands.dispatch atom.views.getView(atom.workspace), 'tab-control:show'
    @subs.add atom.workspace.onDidChangeActivePaneItem =>
      @update()
    @subs.add atom.config.observe 'tab-control.displayInStatusBar', =>
      @updateConfig()

  updateConfig: ->
    @displayInStatusBar = atom.config.get 'tab-control.displayInStatusBar'

  destroy: ->
    @tile?.destroy()
    @tile = null
    @sub?.dispose()
    @sub = null

  update: ->
    editor = atom.workspace.getActiveTextEditor()
    if editor and @displayInStatusBar
      type = if editor.getSoftTabs() then 'Spaces' else 'Tabs'
      length = editor.getTabLength()
      @text "#{type}: #{length}"
      @show()
    else
      @hide()
