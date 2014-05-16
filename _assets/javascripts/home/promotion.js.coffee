delay = @rb757.Utils.delay

class Promotion

  @ends: moment '20130912', 'YYYYMMDD'

  constructor: ->
    @promotion = $('.promotion')
    @aside = @promotion.find('aside')
    @item = @promotion.find('.shirt, .sticker')
    @count = @aside.find('.count')
    @days  = @aside.find('.days')
    # @updateContent()
    @setupEvents()

  gotoPromotion: =>
    window.location.href = 'http://www.stickermule.com/marketplace/1262-757rb-norfolk-ruby&utm_medium=site'

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
    @gotoPromotion()
    false

  bringIn: =>
    @item.addClass('lightSpeedIn')
    @item.show()

  tada: =>
    @item.removeClass 'lightSpeedIn'
    @item.addClass 'tada'
    delay 1000, => @item.removeClass 'tada'

  setupEvents: ->
    @promotion.on 'mousedown touchstart', @mousedown
    @promotion.on 'mouseup touchend', @mouseup
    delay 100, @bringIn
    setInterval @tada, 5000


$ -> rb757.promotion = new Promotion
