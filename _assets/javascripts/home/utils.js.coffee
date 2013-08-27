
@rb757.Utils =

  delay: (time, fn, args...) -> setTimeout fn, time, args...

  # http://coffeescriptcookbook.com/chapters/arrays/shuffling-array-elements
  shuffle: (array) ->
    for i in [array.length-1..1]
      j = Math.floor Math.random() * (i + 1)
      [array[i], array[j]] = [array[j], array[i]]
    array

  ie10: /MSIE 10.0/.test($('html').data('useragent'))

