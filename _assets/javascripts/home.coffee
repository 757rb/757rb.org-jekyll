#= require vendor/zepto-1.0.min

# Utils

@Utils =

  delay: (time, fn, args...) -> setTimeout fn, time, args...

# Pixel Sizes

@Pixels = 
  horizonLeft:       101
  horizonRight:      80
  waves:             46
  wavesToOpening:    25
  mermaid:           27
  mermaidToLeftBody: 17

# Home Layout Manager

class HomeLayout

  constructor: ->
    @horizonLeft  = $('.horizon-left')
    @horizonRight = $('.horizon-right')
    @waves   = $('.waves')
    @mermaid = $('.mermaid')
    @setupMermaidAnimation()
    @setupEvents()

  pixelsPerPixel: ->
    @mermaid.width() / Pixels.mermaid

  # Private

  setupMermaidAnimation: ->
    @mermaid.addClass 'bounceInUp'
    Utils.delay 1000, => 
      @mermaid.removeClass 'bounceInUp'
      @mermaid.addClass    'bobbing'
    true

  setupEvents: ->
    $(window).resize @adjustWaves
    @adjustWaves()
    $(window).resize @adjustClouds
    @adjustClouds()
    
  adjustWaves: =>
    windowWidth = $(window).width()
    mermaidWidth = @mermaid.width()
    mermaidLeftPercentage = Number @mermaid.css('left').replace('%','')
    wavesWidth = @waves.width()
    mermaidToLeftBody = (mermaidWidth / Pixels.mermaid) * Pixels.mermaidToLeftBody
    waveToOpening = (wavesWidth / Pixels.waves) * Pixels.wavesToOpening
    mermaidToLeft = (windowWidth * (mermaidLeftPercentage / 100))
    @waves.css 'left', "#{mermaidToLeft - waveToOpening + mermaidToLeftBody}px"

  adjustClouds: =>
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

Zepto ($) => Utils.delay 50, => @HomeLayout = new HomeLayout

