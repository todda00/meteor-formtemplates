#Global Helpers
Template.registerHelper "selected", (key, val) ->
  return "" if !key? or !val? 
  if key is val then return {selected: "selected"} else return ""

Template.registerHelper "checked", (key, val) ->
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

#Button
Template.button.helpers
  type: ->
    return @type if @type?
    return 'button'

#Toggle
Template.toggle.rendered = ->
  $(@firstNode).bootstrapToggle()

#Radio Buttons
Template.radioButtons.rendered = ->
  @.$("[data-toggle='tooltip']").tooltip({delay:500})

Template.radioButtons.helpers
  active: (key,val) ->
    return "" if !key? or !val?
    if key is val then return @activeClass else return ""

  vertical: ->
    return "-vertical" if @vertical is true

#Checkboxes
Template.checkboxes.rendered = ->
  @.$("[data-toggle='tooltip']").tooltip({delay:500})
