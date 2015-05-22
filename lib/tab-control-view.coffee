{SelectListView} = require 'atom-space-pen-views'

module.exports =
class TabControlView extends SelectListView
  initialize: (@editor) ->
    super
    @addClass('tab-control overlay from-top')
    @list.addClass('mark-active')
    currentTabLength = editor.getTabLength()
    items = for n in [1, 2, 3, 4, 8]
      text: "Tab Width: #{n}"
      command: 'tab-control:set-tab-length'
      options: {tabLength: n}
      active: currentTabLength==n
    items.push
      text: "Indent Using Spaces"
      command: 'editor:toggle-soft-tabs'
      active: editor.getSoftTabs()
    @setItems(items)

  getFilterKey: ->
    "text"

  attach: ->
    @storeFocusedElement()
    atom.workspaceView.append(this)
    @focusFilterEditor()

  viewForItem: (item) ->
    element = document.createElement('li')
    element.classList.add('active') if item.active
    element.textContent = item.text
    element

  confirmed: (item) ->
    @cancel()
    view = atom.workspaceView.getActiveView()
    if view.hasClass('editor')
      view.trigger(item.command, item.options)
