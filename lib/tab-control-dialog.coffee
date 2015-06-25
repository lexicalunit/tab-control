{SelectListView} = require 'atom-space-pen-views'

module.exports =

# Public: Control dialog offering control over tab settings.
class TabControlDialog extends SelectListView
  autoSaveChanges: false
  sub: null

  # Public: Create new control dialog view.
  initialize: (@status) ->
    super
    @addClass 'tab-control'
    @list.addClass 'mark-active'
    this

  # Public: destroy view, cancel any selection.
  destroy: ->
    sub?.dispose()
    @cancel()

  # Public: Shows or hides control dialog.
  toggle: ->
    if @panel?
      @cancel()
    else if @editor = atom.workspace.getActiveTextEditor()
      @setItems @getTabControlItems()
      @attach()

  # Private: Defines fuzzy find item property.
  getFilterKey: ->
    'name'

  # Private: Returns element for each item in view.
  viewForItem: (item) ->
    if item.seperator? and item.seperator
      element = document.createElement 'li'
      element.classList.add 'seperator'
    else
      element = document.createElement 'li'
      element.classList.add 'active' if item.active? and item.active
      element.textContent = item.name if item.name?
    element

  # Private: Override SelectListView to skip over seperators.
  selectPreviousItemView: ->
    view = @getSelectedItemView().prev()
    view = view.prev() if view.hasClass('seperator')
    view = @list.find('li:last') unless view.length
    @selectItemView(view)

  # Private: Override SelectListView to skip over seperators.
  selectNextItemView: ->
    view = @getSelectedItemView().next()
    view = view.next() if view.hasClass('seperator')
    view = @list.find('li:first') unless view.length
    @selectItemView(view)

  # Private: Gets items for control dialog view.
  getTabControlItems: ->
    currentTabLength = @editor.getTabLength()
    items = []
    items.push
      name: "Indent Using Spaces"
      command: (value) => @editor.toggleSoftTabs()
      active: @editor.getSoftTabs()
    items.push {seperator: true}
    for n in [1, 2, 3, 4, 8]
      items.push
        name: "Tab Length: #{n}"
        value: n
        command: (value) => @editor.setTabLength value
        active: currentTabLength is n
    if atom.packages.getActivePackage('tabs-to-spaces')?
      workspace = atom.views.getView(atom.workspace)
      items.push {seperator: true}
      items.push
        name: 'Tabs To Spaces: Tabify'
        command: (value) -> atom.commands.dispatch workspace, 'tabs-to-spaces:tabify'
      items.push
        name: 'Tabs To Spaces: Untabify'
        command: (value) -> atom.commands.dispatch workspace, 'tabs-to-spaces:untabify'
      items.push
        name: 'Tabs To Spaces: Untabify All'
        command: (value) -> atom.commands.dispatch workspace, 'tabs-to-spaces:untabify-all'
    items

  # Private: Called when selection is canceled.
  cancelled: ->
    @panel?.destroy()
    @panel = null
    @editor = null

  # Private: Called when selection is made.
  confirmed: (item) ->
    return unless item?
    return unless item.command?
    if item.value?
      item.command item.value
    else
      item.command()
    @status?.update()
    if @autoSaveChanges
      @saveChanges()
    @cancel()

  # Private: Saves current settings to atom config.
  saveChanges: ->
    scope = atom.workspace.getActiveTextEditor()?.getGrammar()?.scopeName
    return unless scope?
    atom.config.set 'editor.tabLength', @editor.getTabLength(),
      scopeSelector: ".#{scope}"
    atom.config.set 'editor.softTabs', @editor.getSoftTabs(),
      scopeSelector: ".#{scope}"

  # Private: Attach dialog view to workspace.
  attach: ->
    @storeFocusedElement()
    @panel ?= atom.workspace.addModalPanel
      item: this
    @focusFilterEditor()
    @sub = atom.config.observe 'tab-control.autoSaveChanges', =>
      @updateConfig()

  # Private: Updates cache of atom config settings for this package.
  updateConfig: ->
    @autoSaveChanges = atom.config.get 'tab-control.autoSaveChanges'
