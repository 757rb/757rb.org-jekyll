class Chiptune

  constructor: ->
    @track = $('.chiptune')

  play: -> 
    @track.prop 'muted', null

  pause: ->
    @track.prop 'muted', 'muted'


Zepto ($) -> rb757.chiptune = new Chiptune
