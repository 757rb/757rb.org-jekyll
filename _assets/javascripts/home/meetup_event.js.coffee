delay  = @rb757.Utils.delay

class MeetupEvent

  @signedURL = 'http://api.meetup.com/2/events.json/?group_id=1068870&status=upcoming&order=time&limited_events=False&desc=false&offset=0&format=json&page=1&fields=&sig_id=3695330&sig=4a5328681cbfb5dd2e6aea30601627fd107b7db3'

  constructor: ->
    @event = $('.next-adventure')
    @name = @event.find('.name')
    @time = @event.find('time')
    @description = @event.find('.description')
    @rsvp = @event.find('.rsvp')
    @rsvpCount  = @rsvp.find('.rsvp-count')
    @rsvpButton = @rsvp.find('.rsvp-button')
    @getEvent()

  # Events

  rsvpClicked: =>
    window.location.href = @result.event_url

  # Private

  getEvent: ->
    url = @constructor.signedURL
    $.ajax url: url, dataType: 'jsonp', success: @renderEvent

  renderEvent: (data, status, xhr) =>
    @result = data.results[0]
    time = moment(@result.time)
    @time.attr 'datetime', time.toISOString()
    @time.text moment(time).format('MMMM Do YYYY @ h:mma')
    @name.text @result.name
    @description.html @result.description
    @rsvpCount.text @result.yes_rsvp_count
    @setupEvents()
    @present()

  setupEvents: ->
    @rsvpButton.click @rsvpClicked

  present: ->
    @event.show()
    rb757.layoutManager.adjustAdventure()
    @event.addClass 'bounceIn'




$ -> rb757.meetupEvent = new MeetupEvent
