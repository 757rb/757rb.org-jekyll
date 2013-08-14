
# Misc

* Add favicon that works with mobile.
* Start work on meetup.com API integration.
* Put copyright info at bottom. 
  - Credit @cosmic_meow and @metaskills
  - Music "Voices of Experience" by Ben Landis
    https://soundcloud.com/benlandis/voices-of-experience
    https://twitter.com/thebenlandis



# Add links for other 757rb destinations

* Github: https://github.com/757rb
* Meetup Group: http://ruby.meetup.com/130/
* Google Group: http://groups.google.com/group/757rb
* LinkedIn Group: http://www.linkedin.com/groups?gid=727577
* Twitter Updates: http://twitter.com/757rb
* Blip.tv: http://757rb.blip.tv/posts?view=archive&amp;nsfw=dc
  YouTube: http://www.youtube.com/user/norfolk757rb
  


# Meetup.com Integration Notes

Our Next Event - For the box over the mermaid's head. I think keeping the information simple and clean will be nice.

  * Link everything to `event_url` and use pointer CSS.
  * Header showing the `name`. Should be able to take a few lines.
  * Use moment.js to parse the `time` and display the date. Ex: March 24th 2013 at 6:00pm.
  * Use the `yes_rsvp_count` and show some sort of RSVP badge.
  * Description copy using `description`. This has HTML in it like <p> tags which is OK.

http://api.meetup.com/2/events.json/?group_id=1068870&status=upcoming&order=time&limited_events=False&desc=false&offset=0&format=json&page=1&fields=&sig_id=3695330&sig=4a5328681cbfb5dd2e6aea30601627fd107b7db3


Our Players - Idea is to use some area for showing faces. There are around 150 members, so this will have to be in a scroll view. I had considered an idea where the whole top or right side would be a fixed height or width (like 100px) area that showed "PLAYERS:" in a game font. Maybe we can make it auto scroll too.

  * Reduce, remove those with no `photo` attribute.
  * Then randomize the results.
  * Use `photo.thumb_link` for selling faces. Link photo to `link` attribute at meetup.com.
  * Show @username for `other_services.twitter.identifier`. Link to http://twitter.com/@username.
  * Maybe show `name`.

http://api.meetup.com/2/members.json/?group_id=1068870&order=name&offset=0&format=json&only=link%2Cname%2Cphoto%2Cother_services&page=200&sig_id=3695330&sig=71c2f349577843e4245322262b4b6d41fcf62883

  * Use 
    $('.players-area').show()
    $('.players-area').find('img').unveil()

