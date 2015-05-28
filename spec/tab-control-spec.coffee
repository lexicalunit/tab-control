TabControl = require '../lib/tab-control'
path = require 'path'

describe 'TabControl', ->
  [editor, editorView, workspaceElement] =  []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    atom.config.set 'tab-control.displayInStatusBar', true
    waitsForPromise -> atom.packages.activatePackage('status-bar')
    waitsForPromise -> atom.packages.activatePackage('tab-control')

    runs ->
      atom.packages.emitter.emit('did-activate-all')

  describe 'initialize', ->
    it 'displays in the status bar', ->
      expect(TabControl.hook).toBeDefined()

  describe 'when there is no file open', ->
    it 'is not visible', ->
      expect(TabControl.hook.is(":visible")).toBe(false)

  describe 'deactivate', ->
    it 'removes the indicator', ->
      expect(TabControl.hook).toExist()
      atom.packages.deactivatePackage('tab-control')
      expect(TabControl.hook).toBeNull()

    it 'can be executed twice', ->
      atom.packages.deactivatePackage('tab-control')
      atom.packages.deactivatePackage('tab-control')

  describe 'when a file is open', ->
    beforeEach ->
      waitsForPromise -> atom.workspace.open('test.txt')
      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)
        editor.setTabLength(2)
        editor.setSoftTabs(false)

    it 'reflects the editor settings', ->
      expect(TabControl.hook.text()).toBe 'Spaces:2'

  describe 'dialog', ->
    beforeEach ->
      waitsForPromise -> atom.workspace.open('test.txt')
      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editorView = atom.views.getView(editor)
        editor.setTabLength(2)
        editor.setSoftTabs(false)

    describe 'when tab-control:show is triggered', ->
      it 'displays a list of tab lengths', ->
        atom.commands.dispatch(editorView, 'tab-control:show')
        dialog = atom.workspace.getModalPanels()[0].getItem()
        expect(dialog.list.children('li').length).toBe 6
        expect(dialog.list.children('li:first').text()).toBe 'Tab Length: 1'
        expect(dialog.list.children('li.active').text()).toBe 'Tab Length: 2'

    describe 'when an tab length is selected', ->
      it 'sets the new tab length on the editor', ->
        atom.commands.dispatch(editorView, 'tab-control:show')
        dialog = atom.workspace.getModalPanels()[0].getItem()
        listItems = dialog.getTabControlItems()
        dialog.confirmed(listItems[3])
        expect(editor.getTabLength()).toBe 4

    describe 'when Indent Using Spaces is selected', ->
      it 'sets the new soft tabs setting on the editor', ->
        atom.commands.dispatch(editorView, 'tab-control:show')
        dialog = atom.workspace.getModalPanels()[0].getItem()
        listItems = dialog.getTabControlItems()
        dialog.confirmed(listItems[5])
        expect(editor.getSoftTabs()).toBeTruthy()
