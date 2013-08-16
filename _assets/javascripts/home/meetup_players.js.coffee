delay   = @rb757.Utils.delay
shuffle = @rb757.Utils.shuffle

class MeetupPlayers

  @signedURL = 'http://api.meetup.com/2/members.json/?group_id=1068870&order=name&offset=0&format=json&only=link%2Cname%2Cphoto%2Cother_services&page=200&sig_id=3695330&sig=71c2f349577843e4245322262b4b6d41fcf62883'
  @defaultPlayerSrc = 'http://identicons.github.com/metaskills.png'

  constructor: ->
    @players = $('.players')
    @header  = @players.find('header')
    @count   = @players.find('.players-count')
    @health  = @players.find('.players-health')
    @playersArea = $('.players-area')
    @setupEvents()
    @getPlayers()

  # Private

  mousedown: =>
    @players.addClass 'active'
    false

  mouseup: =>
    @players.removeClass 'active'
    false

  setupEvents: ->
    if rb757.touchy
      @players.on 'touchstart', @mousedown
      @players.on 'touchend', @mouseup
    else
      @players.on 'mousedown', @mousedown
      @players.on 'mouseup', @mouseup

  getPlayers: ->
    url = @constructor.signedURL
    $.ajax url: url, dataType: 'jsonp', success: @renderPlayers

  renderPlayers: (data, status, xhr) =>
    players = shuffle(data.results)
    content = $('<section>')
    count = 0
    for player in players when player.photo?.thumb_link
      el    = $ '<aside>', class: 'player', 'data-link': player.link
      link  = $ '<a>', href: player.link
      img   = $ '<img>', src: @constructor.defaultPlayerSrc, 'data-src': player.photo.thumb_link
      el.append(link.append(img))
      content.append el
      count += 1
    # Fancy visual count up.
    health = []
    for i in [1..count] by 1
      do (i) => delay 20 * i, => 
        h = 20 * Math.floor(i / 20 + 0.5)
        unless h in health
          health.push(h)
          @health.text Array(health.length+1).join('Œ')
        @count.text(i)
        if i is count
          @playersArea.append content.html()
    true

Zepto ($) -> rb757.meetupPlayers = new MeetupPlayers
