class PowerUps

  constructor: ->
    @powerUps = $('.power-ups')
    @header = @powerUps.find('header')
    @headerDefaultText = @header.text()
    @powers = @powerUps.find('a')
    @images = @powerUps.find('img')
    @setupEvents()

  # Events

  powerSelected: (e) =>
    img = $(e.target)
    link = img.parent('a')
    otherImages = @images.not(img)
    otherImages.addClass 'off'
    @header.text link.data('name')
    false

  powerDown: =>
    @images.removeClass 'off'
    @header.text @headerDefaultText

  # Private

  setupEvents: ->
    @powers.on   'mouseover': @powerSelected, 'touchstart': @powerSelected, 'touchmove', @powerSelected
    @powerUps.on 'mouseout':  @powerDown,     'touchend':   @powerDown


$ -> rb757.powerUps = new PowerUps
