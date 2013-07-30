#= require vendor/zepto-1.0.min

# Utility

delay = (time, fn, args...) -> setTimeout fn, time, args...

# Site

mermaid = $('.mermaid')
mermaidPixels = 27
mermaidToLeftBodyPixels = 17
mermaidLeftPercentage = Number mermaid.css('left').replace('%','')
mermaid.addClass 'bounceInUp'
delay 1000, -> 
  mermaid.removeClass 'bounceInUp'
  mermaid.addClass    'bobbing'

waves = $('.waves')
wavesPixels = 46.0
wavesToOpeningPixels = 25.0
waveLeftAdjustment = ->
  windowWidth = $(window).width()
  mermaidWidth = mermaid.width()
  wavesWidth = waves.width()
  mermaidToLeftBody = (mermaidWidth / mermaidPixels) * mermaidToLeftBodyPixels
  waveToOpening = (wavesWidth / wavesPixels) * wavesToOpeningPixels
  mermaidToLeft = (windowWidth * (mermaidLeftPercentage / 100))
  waves.css 'left', "#{mermaidToLeft - waveToOpening + mermaidToLeftBody}px"
Zepto ($) -> waveLeftAdjustment()
$(window).resize waveLeftAdjustment
  

