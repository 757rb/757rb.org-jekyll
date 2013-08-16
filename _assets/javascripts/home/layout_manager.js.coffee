delay  = @rb757.Utils.delay
Pixels = @rb757.Pixels

class LayoutManager

  constructor: ->
    @clouds = $('.clouds')
    @birds  = $('.birds')
    @horizonLeft  = $('.horizon-left')
    @horizonRight = $('.horizon-right')
    @waves   = $('.waves')
    @mermaid = $('.mermaid')
    @watery  = $('.watery')
    @setupEvents()

  pixelsPerPixel: ->
    @mermaid.width() / Pixels.mermaid

  # Private

  setupMermaidAnimation: ->
    @mermaid.addClass 'bounceInUp'
    delay 1000, => 
      @mermaid.removeClass 'bounceInUp'
      @mermaid.addClass    'bobbing'
    true

  setupEvents: ->
    $(window).resize @adjustWaves    ; @adjustWaves()
    $(window).resize @adjustHorizons ; @adjustHorizons()
    $(window).resize @adjustClouds   ; @adjustClouds()
    $(window).resize @adjustBirds    ; @adjustBirds()
    delay 200, => @setupMermaidAnimation()

  adjustWaves: =>
    windowWidth = $(window).width()
    mermaidWidth = @mermaid.width()
    mermaidLeftPercentage = Number @mermaid.css('left').replace('%','')
    wavesWidth = @waves.width()
    mermaidToLeftBody = (mermaidWidth / Pixels.mermaid) * Pixels.mermaidToLeftBody
    waveToOpening = (wavesWidth / Pixels.waves) * Pixels.wavesToOpening
    mermaidToLeft = (windowWidth * (mermaidLeftPercentage / 100))
    @waves.css 'left', "#{mermaidToLeft - waveToOpening + mermaidToLeftBody}px"

  adjustHorizons: =>
    ppp = @pixelsPerPixel()
    @adjustHorizon 'Left', ppp
    @adjustHorizon 'Right', ppp

  adjustHorizon: (side, ppp) ->
    h = @["horizon#{side}"]
    hPPP = Pixels["horizon#{side}"] * ppp
    hWidth = h.width()
    images = h.find('.horizon-image')
    hugLeftCSS  = {width: "#{hPPP}px", left: '0', right: 'auto'}
    hugRightCSS = {width: "#{hPPP}px", left: 'auto', right: '0'}
    if side is 'Left'
      if hWidth > hPPP then images.css(hugLeftCSS) else images.css(hugRightCSS)
    else
      if hWidth > hPPP then images.css(hugRightCSS) else images.css(hugLeftCSS)
    h.addClass 'fadeIn' unless h.hasClass 'fadeIn'

  adjustClouds: =>
    ppp = @pixelsPerPixel()
    cPPP = Pixels.clouds * ppp
    screenRatio = $(window).width() / $(window).height()
    animationSeconds = 5 * Math.floor((screenRatio * 5) / 5 + 0.5)
    @clouds.css 'background-size', "#{cPPP}px auto"
    @clouds.addClass 'moving' unless @clouds.hasClass 'moving'
    @clouds.data 'duration', animationSeconds
    @watery.css 'background-size', "#{cPPP}px auto"
    @watery.addClass 'shimmering' unless @clouds.hasClass 'shimmering'
    @watery.data 'duration', animationSeconds

  adjustBirds: =>
    ppp = @pixelsPerPixel()
    bPPP = Pixels.birds * ppp
    @birds.css 'width', "#{bPPP}px"
    @birds.show()


$ -> delay 50, -> rb757.layoutManager = new LayoutManager

