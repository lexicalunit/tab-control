{WorkspaceView} = require 'atom'
TabControl = require '../lib/tab-control'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TabControl", ->
  editor = null
  editorView = null
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    waitsForPromise ->
      atom.workspace.open('test.txt')
    runs ->
      # Unfortunately the promise is not actually fulfilled until you trigger
      # the plugin (when using activationEvents to delay initialization).
      activationPromise = atom.packages.activatePackage('tab-control')


  describe "when the tab-control:show event is triggered", ->
    showTC = ->

    beforeEach ->
      expect(atom.workspaceView.find('.tab-control')).not.toExist()
      editorView = atom.workspaceView.getActiveView()
      expect(editorView).not.toBeUndefined()
      {editor} = editorView

    it "should be active", ->
      editorView.trigger 'tab-control:show'
      waitsForPromise ->
        activationPromise
      runs ->
        # Unfortunately Atom overrides the name in package.json to be whatever
        # the directory is.
        expect(atom.packages.isPackageActive('atom-tab-control')).toBe(true)
        expect(atom.workspaceView.find('.tab-control')).toExist()

    it "should allow selecting a tab length", ->
      editor.setTabLength(2)
      editorView.trigger 'tab-control:show'
      waitsForPromise ->
        activationPromise
      runs ->
        expect(editor.getTabLength()).toBe(2)
        tcView = atom.workspaceView.find('.tab-control').view()
        expect(tcView.items[1].active).toBeTruthy()
        tcView.confirmed(tcView.items[3])
        expect(editor.getTabLength()).toBe(4)

    # This doesn't work I think because the editor is not attached to the DOM?
    # it "should support toggle soft tabs", ->
    #   editor.setSoftTabs(true)
    #   editorView.trigger 'tab-control:show'
    #   waitsForPromise ->
    #     activationPromise
    #   runs ->
    #     expect(editor.getSoftTabs()).toBeTruthy()
    #     tcView = atom.workspaceView.find('.tab-control').view()
    #     item = tcView.items.find((x) -> x.text=="Indent Using Spaces")
    #     tcView.confirmed(item)
    #     expect(editor.getSoftTabs()).toBeFalsy()
