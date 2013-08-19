
@rb757.Pixels = 

  mermaidEl: $('.mermaid')
  
  clouds:            301
  birds:             15
  horizonLeft:       101
  horizonRight:      80
  waves:             46
  wavesToOpening:    25
  mermaid:           27
  mermaidToLeftBody: 17
  powerUp:           16

  ppp: ->
    Math.round @mermaidEl.width() / @mermaid
