delay = @rb757.Utils.delay

class Promotion

  @ends: moment '20130912', 'YYYYMMDD'

  constructor: ->
    @promotion = $('.promotion')
    @aside = @promotion.find('aside')
    @shirt = @promotion.find('.shirt')
    @count = @aside.find('.count')
    @days  = @aside.find('.days')
    @updateContent()
    @setupEvents()

  gotoBooster: =>
    window.location.href = 'http://www.booster.com/757rb?utm_source=757rb&utm_medium=site'

  # Private

  updateContent: ->
    daysLeft = @constructor.ends.diff moment(), 'days'
    if daysLeft < 0
      @aside.text '(campaign closed)'
    else
      @count.text daysLeft
      @days.text if daysLeft is 1 then 'Day' else 'Days'

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
