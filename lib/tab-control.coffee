TabControlView = require './tab-control-view'

module.exports =

  activate: (state) ->
    console.log('STL activate')
    atom.workspaceView.command('tab-control:show', '.editor', @show)
    atom.workspaceView.command('tab-control:set-tab-length', '.editor', @setTabLength)

  show: ->
    console.log('showSTL')
    editor = atom.workspace.getActiveEditor()
    if editor?
      view = new TabControlView(editor)
      view.attach()

  setTabLength: (event, options) ->
    console.log("STL #{options}")
    console.log(event)
    console.log(options)
    editor = atom.workspace.getActiveEditor()
    if editor? and options?.tabLength?
      editor.setTabLength(options.tabLength)
