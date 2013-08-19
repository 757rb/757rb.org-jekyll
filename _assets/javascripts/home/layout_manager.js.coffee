delay  = @rb757.Utils.delay
Pixels = @rb757.Pixels

class LayoutManager

  constructor: ->
    @clouds = $('.clouds')
    @birds  = $('.birds')
    @horizonLeft   = $('.horizon-left')
    @horizonRight  = $('.horizon-right')
    @nextAdventure = $('.next-adventure')
    @waves    = $('.waves')
    @mermaid  = $('.mermaid')
    @watery   = $('.watery')
    @powerUps = $('.power-ups')
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
    $(window).resize @adjustPowerUps  ; @adjustPowerUps()
    delay 200, => @setupMermaidAnimation()

  setPPP: =>
    @ppp = Pixels.ppp()

  adjustWaves: =>
    windowWidth = $(window).width()
    mermaidWidth = @mermaid.width()
    mermaidLeft = Number @mermaid.css('left').replace('px','')
    wavesWidth = @waves.width()
    mermaidToLeftBody = (mermaidWidth / Pixels.mermaid) * Pixels.mermaidToLeftBody
    waveToOpening = (wavesWidth / Pixels.waves) * Pixels.wavesToOpening
    @waves.css 'left', "#{mermaidLeft - waveToOpening + mermaidToLeftBody}px"

  adjustHorizons: =>
    @adjustHorizon 'Left'
    @adjustHorizon 'Right'

  adjustHorizon: (side) ->
    h = @["horizon#{side}"]
    ppp = Pixels["horizon#{side}"] * @ppp
    hWidth = h.width()
    images = h.find('.horizon-image')
    hugLeftCSS  = {width: "#{ppp}px", left: '0', right: 'auto'}
    hugRightCSS = {width: "#{ppp}px", left: 'auto', right: '0'}
    if side is 'Left'
      if hWidth > ppp then images.css(hugLeftCSS) else images.css(hugRightCSS)
    else
      if hWidth > ppp then images.css(hugRightCSS) else images.css(hugLeftCSS)
    h.addClass 'fadeIn' unless h.hasClass 'fadeIn'

  adjustClouds: =>
    ppp = Pixels.clouds * @ppp
    screenRatio = $(window).width() / $(window).height()
    animationSeconds = 5 * Math.floor((screenRatio * 5) / 5 + 0.5)
    @clouds.css 'background-size', "#{ppp}px auto"
    @clouds.addClass 'moving' unless @clouds.hasClass 'moving'
    @clouds.data 'duration', animationSeconds
    @watery.css 'background-size', "#{ppp}px auto"
    @watery.addClass 'shimmering' unless @clouds.hasClass 'shimmering'
    @watery.data 'duration', animationSeconds

  adjustBirds: =>
    ppp = Pixels.birds * @ppp
    @birds.css 'width', "#{ppp}px"
    @birds.show()

  adjustAdventure: =>
    @nextAdventure.css 'border-width': Math.round(@ppp * 8)

  adjustPowerUps: =>
    ppp = Math.round(Pixels.powerUp * (@ppp / 2))
    @powerUps.css 'height', "#{ppp}px"
    @powerUps.find('img').css 'height', "#{ppp}px"


$ -> delay 50, -> rb757.layoutManager = new LayoutManager

