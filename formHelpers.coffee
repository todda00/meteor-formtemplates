window.processForm = (target) ->
  form = {}
  array = $(target).serializeArray()
  _.each array, (formItem) ->
    type = $(target).find("input[name='" + formItem.name + "']").attr("type")
    classList = $(target).find("input[name='" + formItem.name + "']").attr('class')
    classes = if classList? then classList.split(/\s+/) else []

    #consider datepicker a date type even though its not and HTML Date field
    type = 'date' if 'datepicker' in classes

    if type is "date" and !!formItem.value
      form[formItem.name] = new Date(formItem.value + " 00:00")
    else if type is "checkbox"
      if !form[formItem.name]?
        form[formItem.name] = []
      form[formItem.name].push(formItem.value)
    else
      form[formItem.name] = formItem.value

  return form
