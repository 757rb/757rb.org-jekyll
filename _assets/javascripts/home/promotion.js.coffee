delay = @rb757.Utils.delay

class Promotion

  constructor: ->
    @promotion = $('.promotion')
    @shirt = @promotion.find('.shirt')
    @setupEvents()

  gotoBooster: =>
    window.location.href = 'http://www.booster.com/757rb'

  # Private

  mousedown: =>
    @promotion.addClass 'active'
    false

  mouseup: =>
    @promotion.removeClass 'active'
    @gotoBooster()
    false

  bringIn: =>
    @shirt.addClass('lightSpeedIn')
    @shirt.show()

  tada: =>
    @shirt.removeClass 'lightSpeedIn'
    @shirt.addClass 'tada'
    delay 1000, => @shirt.removeClass 'tada'

  setupEvents: ->
    @promotion.on 'mousedown touchstart', @mousedown
    @promotion.on 'mouseup touchend', @mouseup
    delay 100, @bringIn
    setInterval @tada, 5000


$ -> rb757.promotion = new Promotion
