delay  = @rb757.Utils.delay

class MeetupEvent

  @signedURL = 'http://api.meetup.com/2/events.json/?group_id=1068870&status=upcoming&order=time&limited_events=False&desc=false&offset=0&format=json&page=1&fields=&sig_id=3695330&sig=4a5328681cbfb5dd2e6aea30601627fd107b7db3'

  constructor: ->
    @event = $('.next-adventure')
    @name = @event.find('.name')
    @description = @event.find('.description')
    @getEvent()

  # Private

  getEvent: ->
    url = @constructor.signedURL
    $.ajax url: url, dataType: 'jsonp', success: @renderEvent

  renderEvent: (data, status, xhr) =>
    event = data.results[0]
    @name.text        event.name
    @description.html event.description
    # console.log event


$ -> rb757.meetupEvent = new MeetupEvent
