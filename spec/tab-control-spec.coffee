path = require 'path'

describe "TabControl", ->
  [activationPromise, editor, editorView, workspaceElement] =  []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    waitsForPromise -> atom.workspace.open('test.txt')

    runs ->
      activationPromise = atom.packages.activatePackage('tab-control')
      editor = atom.workspace.getActiveTextEditor()
      editorView = atom.views.getView(editor)

  describe "when tab-control:show is triggered", ->
    it "displays a list of tab lengths", ->
      editor.setTabLength(2)
      editor.setSoftTabs(false)
      atom.commands.dispatch(editorView, 'tab-control:show')
      waitsForPromise -> activationPromise
      tabControlView = atom.workspace.getModalPanels()[0].getItem()
      expect(tabControlView.list.children('li').length).toBe 6
      expect(tabControlView.list.children('li:first').text()).toBe 'Tab Width: 1'
      expect(tabControlView.list.children('li.active').text()).toBe 'Tab Width: 2'
      tabControlView.cancelled()

  describe "when a tab length is selected", ->
    it "sets the new tab length on the editor", ->
      editor.setTabLength(2)
      editor.setSoftTabs(false)
      atom.commands.dispatch(editorView, 'tab-control:show')
      waitsForPromise -> activationPromise
      tabControlView = atom.workspace.getModalPanels()[0].getItem()
      listItems = tabControlView.getTabControlItems()
      tabControlView.confirmed(listItems[3])
      expect(editor.getTabLength()).toBe 4

  describe "when Indent Using Spaces is selected", ->
    it "sets the new soft tabs setting on the editor", ->
      editor.setTabLength(2)
      editor.setSoftTabs(false)
      atom.commands.dispatch(editorView, 'tab-control:show')
      waitsForPromise -> activationPromise
      tabControlView = atom.workspace.getModalPanels()[0].getItem()
      listItems = tabControlView.getTabControlItems()
      tabControlView.confirmed(listItems[5])
      expect(editor.getSoftTabs()).toBeTruthy()
