require! {
  '../../modules/aktos-dcs': {
    RactivePartial,
    WidgetActor,
  }
}
  
RactivePartial! .register ->
  $ '.jq-checkbox' .each !->
    elem = $ this
    actor = WidgetActor elem
    
    input = elem.find \.jq-checkbox__input

    input.change ->
      state = input.is \:checked
      console.log "jq-checkbox changed: #state"
      actor.gui-event state
      
    actor.add-callback (msg) ->
      input.prop 'checked', msg.val .checkboxradio \refresh
