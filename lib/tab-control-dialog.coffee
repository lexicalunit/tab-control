{SelectListView} = require 'atom-space-pen-views'

module.exports =
class TabControlDialog extends SelectListView
  autoSaveChanges: false
  sub: null

  initialize: (@status) ->
    super
    @addClass 'tab-control'
    @list.addClass 'mark-active'
    this

  getFilterKey: ->
    'name'

  destroy: ->
    sub?.dispose()
    @cancel()

  viewForItem: (item) ->
    element = document.createElement 'li'
    element.classList.add 'active' if item.active
    element.textContent = item.text
    element

  cancelled: ->
    @panel?.destroy()
    @panel = null
    @editor = null

  confirmed: (item) ->
    item.command item.value
    @status?.update()
    if @autoSaveChanges
      @saveChanges()
    @cancel()

  saveChanges: ->
    scope = atom.workspace.getActiveTextEditor()?.getGrammar()?.scopeName
    return unless scope?
    atom.config.set 'editor.tabLength', @editor.getTabLength(),
      scopeSelector: scope

  attach: ->
    @storeFocusedElement()
    @panel ?= atom.workspace.addModalPanel
      item: this
    @focusFilterEditor()
    @sub = atom.config.observe 'tab-control.autoSaveChanges', =>
      @updateConfig()

  updateConfig: ->
    @autoSaveChanges = atom.config.get 'tab-control.autoSaveChanges'

  toggle: ->
    if @panel?
      @cancel()
    else if @editor = atom.workspace.getActiveTextEditor()
      @setItems @getTabControlItems()
      @attach()

  getTabControlItems: ->
    currentTabLength = @editor.getTabLength()
    items = for n in [1, 2, 3, 4, 8]
      text: "Tab Length: #{n}"
      value: n
      command: (value) => @editor.setTabLength value
      active: currentTabLength == n
    items.push
      text: "Indent Using Spaces"
      value: null
      command: (value) => @editor.toggleSoftTabs()
      active: @editor.getSoftTabs()
    items
