#= require vendor/zepto-1.0.min

# Utility

delay = (time, fn, args...) -> setTimeout fn, time, args...

# Site

mermaid = $('.mermaid')
mermaid.addClass 'bounceInUp'
delay 1000, -> 
  mermaid.removeClass 'bounceInUp'
  mermaid.addClass    'bobbing'

