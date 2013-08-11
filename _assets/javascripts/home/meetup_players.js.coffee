delay   = @rb757.Utils.delay
shuffle = @rb757.Utils.shuffle

class MeetupPlayers

  @signedURL = 'http://api.meetup.com/2/members.json/?group_id=1068870&order=name&offset=0&format=json&only=link%2Cname%2Cphoto%2Cother_services&page=200&sig_id=3695330&sig=71c2f349577843e4245322262b4b6d41fcf62883'

  constructor: ->
    @players = $('.players')
    @getPlayers()

  # Private

  getPlayers: ->
    url = @constructor.signedURL
    $.ajax url: url, dataType: 'jsonp', success: @renderPlayers

  renderPlayers: (data, status, xhr) =>
    players = shuffle(data.results)
    content = $('<section>')
    for player in players when player.photo?.thumb_link
      el    = $ '<aside>', class: 'player', 'data-link': player.link
      link  = $ '<a>', href: player.link
      img   = $ '<img>', src: player.photo.thumb_link
      el.append(link.append(img))
      content.append el
    @players.append content.html()
    true

# Zepto ($) -> rb757.meetupPlayers = new MeetupPlayers
