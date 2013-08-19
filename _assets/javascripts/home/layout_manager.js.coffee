delay  = @rb757.Utils.delay
Pixels = @rb757.Pixels

class LayoutManager

  constructor: ->
    @html   = $('html')
    @clouds = $('.clouds')
    @birds  = $('.birds')
    @horizonLeft   = $('.horizon-left')
    @horizonRight  = $('.horizon-right')
    @nextAdventure = $('.next-adventure')
    @rsvpButton    = $('.rsvp-button')
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
    $(window).resize @adjustFontSize  ; @adjustFontSize()
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
    @rsvpButton.css 'border-width': Math.round(@ppp * 2)

  adjustPowerUps: =>
    ppp = Math.round(Pixels.powerUp * (@ppp / 2))
    @powerUps.css 'height', "#{ppp}px"
    @powerUps.find('img').css 'height', "#{ppp}px"

  adjustFontSize: =>
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


$ -> delay 50, -> rb757.layoutManager = new LayoutManager

