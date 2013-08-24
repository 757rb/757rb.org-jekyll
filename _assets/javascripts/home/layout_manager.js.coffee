delay  = @rb757.Utils.delay
Pixels = @rb757.Pixels

class LayoutManager

  constructor: ->
    @html   = $('html')
    @clouds = $('.clouds')
    @birds  = $('.birds')
    @gameInfo = $('.game-info')
    @horizonLeft   = $('.horizon-left')
    @horizonRight  = $('.horizon-right')
    @horizonImageFront = $('.horizon-image-front')
    @horizonImageBack  = $('.horizon-image-back')
    @nextAdventure = $('.next-adventure')
    @rsvpButton    = $('.rsvp-button')
    @waves    = $('.waves')
    @mermaid  = $('.mermaid')
    @water    = $('.water')
    @watery   = $('.watery')
    @powerUps = $('.power-ups')
    @credits  = $('.credits')
    @setupEvents()

  # Private

  setupEvents: ->
    $(window).resize @adjustWindow
    @adjustWindow()
    delay 200, => @setupMermaidAnimation()

  setupMermaidAnimation: ->
    @mermaid.addClass 'bounceInUp'
    delay 1000, => 
      @mermaid.removeClass 'bounceInUp'
      @mermaid.addClass    'bobbing'
      @plaxSetup()
    true

  plaxSetup: ->
    @horizonImageFront.plaxify  xRange: 20, yRange: 20
    @clouds.plaxify             xRange: 20, yRange: 20, invert: true
    @horizonImageBack.plaxify   xRange: 10, yRange: 10, invert: true
    $.plax.enable()

  plaxReallyRestorePositions: ->
    plaxRange = 20
    plaxRangePx = "-#{plaxRange}px"
    @horizonLeft.find('.horizon-image').css  top: 'auto', right: 'auto',      bottom: plaxRangePx, left: plaxRangePx
    @horizonRight.find('.horizon-image').css top: 'auto', right: plaxRangePx, bottom: plaxRangePx, left: 'auto'

  adjustWindow: =>
    rb757.credits.reset()
    $.plax.disable restorePositions: true, clearLayers: true
    @plaxReallyRestorePositions()
    @setPPP()
    @adjustFontSize()
    @adjustGameInfo()
    @adjustWaves()
    @adjustHorizons()
    @adjustClouds()
    @adjustBirds()
    @adjustAdventure()
    @adjustPowerUps()
    @adjustCredits()
    @plaxSetup()

  setPPP: ->
    @ppp = Pixels.ppp()

  adjustWaves: ->
    windowWidth = $(window).width()
    mermaidWidth = @mermaid.width()
    mermaidLeft = Number @mermaid.css('left').replace('px','')
    wavesWidth = @waves.width()
    mermaidToLeftBody = (mermaidWidth / Pixels.mermaid) * Pixels.mermaidToLeftBody
    waveToOpening = (wavesWidth / Pixels.waves) * Pixels.wavesToOpening
    @waves.css 'left', "#{mermaidLeft - waveToOpening + mermaidToLeftBody}px"

  adjustHorizons: ->
    @adjustHorizon 'Left'
    @adjustHorizon 'Right'

  adjustHorizon: (side) ->
    plaxRange = 20
    plaxRangePx = "-#{plaxRange}px"
    h = @["horizon#{side}"]
    ppp = Pixels["horizon#{side}"] * @ppp + plaxRange
    hWidth = h.width()
    images = h.find('.horizon-image')
    hugLeftCSS  = {width: "#{ppp}px", left: plaxRangePx, bottom: plaxRangePx, right: 'auto'}
    hugRightCSS = {width: "#{ppp}px", left: 'auto',      bottom: plaxRangePx, right: plaxRangePx}
    if side is 'Left'
      if hWidth > ppp then images.css(hugLeftCSS) else images.css(hugRightCSS)
    else
      if hWidth > ppp then images.css(hugRightCSS) else images.css(hugLeftCSS)
    h.addClass 'fadeIn' unless h.hasClass 'fadeIn'

  adjustClouds: ->
    plaxRange = 20
    ppp = Pixels.clouds * @ppp + plaxRange
    screenRatio = $(window).width() / $(window).height()
    animationSeconds = 5 * Math.floor((screenRatio * 5) / 5 + 0.5)
    @clouds.css 'background-size', "#{ppp}px auto"
    @clouds.addClass 'moving' unless @clouds.hasClass 'moving'
    @clouds.data 'duration', animationSeconds
    @watery.css 'background-size', "#{ppp}px auto"
    @watery.addClass 'shimmering' unless @clouds.hasClass 'shimmering'
    @watery.data 'duration', animationSeconds

  adjustBirds: ->
    ppp = Pixels.birds * @ppp
    @birds.css 'width', "#{ppp}px"
    @birds.show()

  adjustAdventure: ->
    @nextAdventure.css 'border-width': Math.round(@ppp * 8)
    @rsvpButton.css 'border-width': Math.round(@ppp * 2)
    overflow = => @nextAdventure.get(0).scrollHeight > @nextAdventure.height()
    percentage = Math.round(Number(@nextAdventure.css('width').replace('px','')) / $(window).width() * 100)
    while !overflow() and percentage > 46
      percentage -= 5
      left = (100 - percentage) / 2
      @nextAdventure.css width: "#{percentage}%", left: "#{left}%"
    while overflow() and percentage < 90
      percentage += 5
      left = (100 - percentage) / 2
      @nextAdventure.css width: "#{percentage}%", left: "#{left}%"
    true

  adjustPowerUps: ->
    ppp = Math.round(Pixels.powerUp * (@ppp / 2))
    @powerUps.css 'height', "#{ppp}px"
    @powerUps.find('img').css 'height', "#{ppp}px"

  adjustFontSize: ->
    fs = switch @ppp
           when 10 then @ppp + 37
           when 9  then @ppp + 27
           when 8  then @ppp + 23
           when 7  then @ppp + 17
           when 6  then @ppp + 15
           when 5  then @ppp + 14
           when 4  then @ppp + 10
           when 3  then @ppp + 9
           when 2  then @ppp + 8
           when 1  then @ppp + 7
           else 14
    @html.css 'font-size', "#{fs}px"

  adjustCredits: ->
    ppp = Pixels.seaFloor * @ppp * 0.6
    @credits.css 'background-size', "#{ppp}px auto"
    avatars = $('.credit-info img')
    avatarWidth = Math.round($(window).width() / 22)
    avatars.css width: "#{avatarWidth}px", height: "#{avatarWidth}px"

  adjustGameInfo: ->
    percentage = => Math.round(@gameInfo.width() / $(window).width() * 100)
    while percentage() > 50
      fs = @html.css('font-size').replace('px','')
      @html.css 'font-size', "#{fs-1}px"


$ -> delay 50, -> rb757.layoutManager = new LayoutManager

