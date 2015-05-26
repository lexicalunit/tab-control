commandDisposable = null
tabControlView = null

module.exports =
  activate: ->
    commandDisposable =
      atom.commands.add('atom-workspace', 'tab-control:show', createTabControlView)

  deactivate: ->
    commandDisposable?.dispose()
    commandDisposable = null

createTabControlView = ->
  unless tabControlView?
    TabControlView = require './tab-control-view'
    tabControlView = new TabControlView()
  tabControlView.toggle()
