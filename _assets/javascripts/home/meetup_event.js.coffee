delay  = @rb757.Utils.delay

class MeetupEvent

  @signedURL = 'https://api.meetup.com/2/events.json/?offset=0&format=json&limited_events=False&group_id=1068870&page=1&fields=&order=time&status=upcoming&desc=false&sig_id=3695330&sig=b9ec7a49f3527a5757fe59b5af16fb368047d70e'

  constructor: ->
    @event = $('.next-adventure')
    @name = @event.find('.name')
    @time = @event.find('time')
    @description = @event.find('.description')
    @metaDescription = $('#meta-description')
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
    description = @result.description.split('</p>')[0].replace('<p>','')
    @time.attr 'datetime', time.toISOString()
    @time.find('.month').text time.format('MMM')
    @time.find('.day').text   time.format('DD')
    @name.text @result.name
    @description.html "<p>#{description}</p>"
    @metaDescription.attr 'content', description
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
