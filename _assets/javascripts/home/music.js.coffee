class Chiptune

  constructor: ->
    @audio = $('.chiptune')
    @controls = $('.audio-controls')
    @uiState = $('.audio-state')
    @uiOn = @uiState.data('on')
    @uiOff = @uiState.data('off')
    @on = not @isMuted()
    @toggle(@on)
    @setupEvents()

  play: -> 
    @on = true
    @audio.prop 'muted', null
    @uiState.text '(on)'

  pause: ->
    @on = false
    @audio.prop 'muted', 'muted'
    @uiState.text '(off)'

  toggle: (set) ->
    isOn = if set then !set else @on
    if isOn then @pause() else @play()

  isMuted: ->
    @audio.prop 'muted'

  # Private

  mousedown: =>
    @controls.addClass 'active'

  mouseup: =>
    @controls.removeClass 'active'
    @toggle()

  setupEvents: ->
    @controls.on 'mousedown', @mousedown
    @controls.on 'mouseup', @mouseup


Zepto ($) -> rb757.chiptune = new Chiptune
