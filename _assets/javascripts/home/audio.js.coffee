class Audio

  constructor: ->
    @audio    = $('audio')
    @controls = $('.audio-controls')
    @uiState  = $('.audio-state')
    @uiOn     = @uiState.data('on')
    @uiOff    = @uiState.data('off')
    @on       = not @prefIsMuted()
    if @on then @play() else @pause()
    @setupEvents()

  play: -> 
    @on = true
    @prefOn()
    @audioPlay()
    @uiState.text @uiOn

  pause: ->
    @on = false
    @prefOff()
    @audioPause()
    @uiState.text @uiOff

  toggle: ->
    if @on then @pause() else @play()

  # Private

  audioPlay:  -> @audio.prop 'muted', null
  audioPause: -> @audio.prop 'muted', 'muted'
  audioMuted: -> @audio.prop 'muted'

  pref:        -> $.cookie 'audio'
  prefOn:      -> $.cookie 'audio', 'on',    expires: 7
  prefOff:     -> $.cookie 'audio', 'muted', expires: 7
  prefIsMuted: -> @pref() is 'muted'

  mousedown: =>
    @controls.addClass 'active'

  mouseup: =>
    @controls.removeClass 'active'
    @toggle()

  setupEvents: ->
    @controls.on 'mousedown', @mousedown
    @controls.on 'mouseup', @mouseup


Zepto ($) -> rb757.audio = new Audio
