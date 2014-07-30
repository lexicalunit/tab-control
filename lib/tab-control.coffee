TabControlView = require './tab-control-view'

module.exports =

  activate: (state) ->
    atom.workspaceView.command('tab-control:show', '.editor', @show)
    atom.workspaceView.command('tab-control:set-tab-length', '.editor', @setTabLength)

  show: ->
    editor = atom.workspace.getActiveEditor()
    if editor?
      view = new TabControlView(editor)
      view.attach()

  setTabLength: (event, options) ->
    editor = atom.workspace.getActiveEditor()
    if editor? and options?.tabLength?
      editor.setTabLength(options.tabLength)
