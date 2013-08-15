touchy = $.os.tablet or $.os.phone

class Audio

  constructor: ->
    @audio    = $('audio').get(0)
    @controls = $('.audio-controls')
    @uiState  = $('.audio-state')
    @uiOn     = @uiState.data('on')
    @uiOff    = @uiState.data('off')
    @on       = not @prefIsOff()
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

  audioPlay:   -> @audio.play()
  audioPause:  -> @audio.pause()
  audioPaused: -> @audio.paused

  pref:      -> $.cookie 'audio'
  prefOn:    -> $.cookie 'audio', 'on',  expires: 7
  prefOff:   -> $.cookie 'audio', 'off', expires: 7
  prefIsOff: -> @pref() is 'off'

  mousedown: =>
    @controls.addClass 'active'
    false

  mouseup: =>
    @controls.removeClass 'active'
    @toggle()
    false

  setupEvents: ->
    if touchy
      @controls.on 'touchstart', @mousedown
      @controls.on 'touchend', @mouseup
    else
      @controls.on 'mousedown', @mousedown
      @controls.on 'mouseup', @mouseup


Zepto ($) -> rb757.audio = new Audio
