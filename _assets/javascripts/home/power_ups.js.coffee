class PowerUps

  constructor: ->
    @powerUps = $('.power-ups')
    @header = @powerUps.find('header')
    @headerDefaultText = @header.text()
    @images = @powerUps.find('img')
    @currentImage = undefined
    @setupEvents()

  # Events

  powerInfo: (e) =>
    return unless img = @imageFromEvent(e)
    @currentImage = img
    img.addClass 'hover'
    otherImages = @images.not(img)
    otherImages.removeClass('hover').addClass('off')
    @header.text img.data('name')
    false

  powerDown: =>
    @images.removeClass 'off hover down'
    @header.text @headerDefaultText
    @currentImage = undefined

  powerMouseDown: (e) =>
    return unless img = @imageFromEvent(e)
    @currentImage = img
    img.removeClass('hover').addClass('down')

  powerUp: (e) =>
    window.location.href = @currentImage.data('href') if @currentImage?
    @powerDown()

  imageFromEvent: (e) ->
    oe = e.originalEvent
    img = if (oe.touches?) then $(document.elementFromPoint(oe.pageX, oe.pageY)) else $(e.target)
    if @images.is(img) then img else false

  # Private

  setupEvents: ->
    @powerUps.on 'mouseover touchstart touchmove', @powerInfo
    @powerUps.on 'mousedown', @powerMouseDown
    @powerUps.on 'mouseout', @powerDown
    @powerUps.on 'mouseup touchend', @powerUp


$ -> rb757.powerUps = new PowerUps
