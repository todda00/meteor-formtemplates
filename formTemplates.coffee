#Global Helpers
Template.registerHelper "selected", (key, val) ->
  key = key.toString()
  val = val.toString()
  return "" if !key? or !val?
  if key is val then return {selected: "selected"} else return ""

Template.registerHelper "checked", (key, val) ->
  key = key.toString()
  return "" if !key? or !val?
  if key in val then return {checked: "checked"} else return ""

Template.registerHelper "checkedBool", (val) ->
  return "" if !val?
  if val is true then return {checked: "checked"} else return ""

Template.registerHelper "checkedSingle", (key, val) ->
  return "" if !key? or !val?
  if key is val then return {checked: "checked"} else return ""

Template.registerHelper "tooltipPos", ->
  return @tooltipPos if @tooltipPos?
  return "right"

Template.registerHelper "iconLeft", ->
  return false if !@icon?
  return true if !@iconPosition?
  return true if @iconPositon is 'left'

Template.registerHelper "iconRight", ->
  return false if !@iconPosition?
  return true if @iconPosition is 'right'

Template.registerHelper "tooltip", ->
  return 'tooltip' if this.details?

#text field
Template.text_field.helpers
  showAddon:->
    return true if @icon? or @label?
    return false

#Button
Template.button.helpers
  type: ->
    return @type if @type?
    return 'button'

#Toggle
Template.toggle.rendered = ->
  @.$(@firstNode).bootstrapToggle()

#Radio Buttons
Template.radioButtons.rendered = ->
  @.$("[data-toggle='tooltip']").tooltip({delay:500})

Template.radioButtons.helpers
  active: (key,val) ->
    return "" if !key? or !val?
    if key is val then return @activeClass else return ""

  vertical: ->
    return "-vertical" if @vertical is true

#Check Buttons
Template.checkButtons.rendered = ->
  @.$("[data-toggle='tooltip']").tooltip({delay:500})

Template.checkButtons.helpers
  active: (key,val) ->
    return "" if !key? or !val?
    if key is val then return @activeClass else return ""

  vertical: ->
    return "-vertical" if @vertical is true

#Select Picker
Template.selectpicker.rendered = ->
  $(@.firstNode).selectpicker()

Template.selectpicker.destroyed = ->
  $("[name='"+@data.name+"']").selectpicker('destroy')

#Important that the option remains in its own template for bootstrap select reactivity
refreshSelectpicker = ->
  if(renderTimeout isnt false)
    Meteor.clearTimeout(renderTimeout)

  renderTimeout = Meteor.setTimeout ->
    $('.selectpicker').selectpicker("refresh")
    renderTimeout = false
  , 10

Template.selectpickerOption.rendered = ->
  refreshSelectpicker()

Template.selectpickerOption.destroyed = ->
  refreshSelectpicker()

Template.selectpickerOption.helpers
  value: ->
    return @ if !@value?
    return @value
  display: ->
    return @ if !@display?
    return @display


#Date picker
Template.datepicker.rendered = ->
  $(@.firstNode).datepicker()

Template.datepicker.destroyed = ->
  $(@.firstNode).datepicker('remove')

#Checkboxes
Template.checkboxes.helpers
  blankName: ->
    return 'blank-'+@name
  value: ->
    return @ if !@value?
    return @value
  display: ->
    return @ if !@display?
    return @display

Template.checkboxes.rendered = ->
  @.$("[data-toggle='tooltip']").tooltip({delay:500})

#List Group
Template.listGroup.created = ->
  @editing = new ReactiveVar()

Template.listGroup.helpers
  editing: ->
    return Template.instance().editing.get()
  displayName: (value, object) ->
    item = _.findWhere(object, {value:value})
    return @ if !item?
    return item.display
  noRecords: (items) ->
    return true if !items?
    return (items.length is 0)


Template.listGroup.events
  'click .edit': (e,t) ->
    t.editing.set(!t.editing.get())

  'click .save': (e,t) ->
    form = processForm(t.find('form'))
    item = Template.parentData()
    return if !window[t.data.collection]?
    Collection = window[t.data.collection]
    Collection.update({_id:item._id},{$set:form})
    t.editing.set(!t.editing.get())

# File Browse
# This is a hidden file field, with a visible button which clicks the input to prompt for a file
Template.fileBrowse.rendered = ->
  @.$("[type='file']").hide()

Template.fileBrowse.helpers
  #Strip the ID that is going to the button so there are not 2 elements with the same ID
  passVarsToButton: ->
    delete @id
    return @

Template.fileBrowse.events
  'click button': (e,t) ->
    t.$("[type='file']").click()
