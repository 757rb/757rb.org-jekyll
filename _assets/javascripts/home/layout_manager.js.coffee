delay  = @rb757.Utils.delay
Pixels = @rb757.Pixels

class LayoutManager

  constructor: ->
    @clouds = $('.clouds')
    @birds  = $('.birds')
    @horizonLeft  = $('.horizon-left')
    @horizonRight = $('.horizon-right')
    @nextAdventure = $('.next-adventure')
    @waves   = $('.waves')
    @mermaid = $('.mermaid')
    @watery  = $('.watery')
    @setupEvents()

  # Private

  setupMermaidAnimation: ->
    @mermaid.addClass 'bounceInUp'
    delay 1000, => 
      @mermaid.removeClass 'bounceInUp'
      @mermaid.addClass    'bobbing'
    true

  setupEvents: ->
    $(window).resize @setPPP          ; @setPPP()
    $(window).resize @adjustWaves     ; @adjustWaves()
    $(window).resize @adjustHorizons  ; @adjustHorizons()
    $(window).resize @adjustClouds    ; @adjustClouds()
    $(window).resize @adjustBirds     ; @adjustBirds()
    $(window).resize @adjustAdventure ; @adjustAdventure()
    delay 200, => @setupMermaidAnimation()

  setPPP: =>
    @ppp = Pixels.ppp()

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
    @adjustHorizon 'Left'
    @adjustHorizon 'Right'

  adjustHorizon: (side) ->
    h = @["horizon#{side}"]
    hPPP = Pixels["horizon#{side}"] * @ppp
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
    cPPP = Pixels.clouds * @ppp
    screenRatio = $(window).width() / $(window).height()
    animationSeconds = 5 * Math.floor((screenRatio * 5) / 5 + 0.5)
    @clouds.css 'background-size', "#{cPPP}px auto"
    @clouds.addClass 'moving' unless @clouds.hasClass 'moving'
    @clouds.data 'duration', animationSeconds
    @watery.css 'background-size', "#{cPPP}px auto"
    @watery.addClass 'shimmering' unless @clouds.hasClass 'shimmering'
    @watery.data 'duration', animationSeconds

  adjustBirds: =>
    bPPP = Pixels.birds * @ppp
    @birds.css 'width', "#{bPPP}px"
    @birds.show()

  adjustAdventure: =>
    @nextAdventure.css 'border-width': @ppp * 9


$ -> delay 50, -> rb757.layoutManager = new LayoutManager

