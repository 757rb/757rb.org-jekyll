delay  = @rb757.Utils.delay

class Credits

  constructor: ->
    @open = false
    @water = $('.water')
    @credit = $('.more-credits')
    @creditHdr = @credit.find('header')
    @creditDirection = @creditHdr.find('.more-credits-direction')
    @credits = $('.credits')
    @crab = @credits.find('.crab')
    @avatars = @credits.find '.avatar'
    @setupEvents()

  show: ->
    return if @open
    delay 300, => @avatars.unveil()
    delay 300, => @crab.addClass('walking')
    @credits.removeClass('down').addClass('up')
    @water.removeClass('down').addClass('up')
    @creditDirection.removeClass('down').addClass('up').text ":"
    @open = true

  hide: ->
    return unless @open
    @water.removeClass('up').addClass('down')
    @credits.removeClass('up').addClass('down')
    @creditDirection.removeClass('up').addClass('down').text "\u2026"
    @open = false

  toggle: =>
    if @open then @hide() else @show()

  reset: ->
    @water.removeClass('up')
    @credits.removeClass('up')
    @open = false

  # Private

  mousedown: =>
    @creditHdr.addClass 'active'
    false

  mouseup: =>
    @creditHdr.removeClass 'active'
    @toggle()
    false

  setupEvents: ->
    @credit.on 'mousedown touchstart', @mousedown
    @credit.on 'mouseup touchend', @mouseup


$ -> rb757.credits = new Credits
