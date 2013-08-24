
# Misc

* Get IE10 CSS border images hacked up.
  http://stackoverflow.com/questions/16695521/any-way-to-hack-internet-explorer-10-to-display-border-image
* Animate mermaid eye blinks.
* Use the sass-mediaqueries gem for responsive mobile "phone" site.
  - Strip away much of the hotness.
* Add desktop picture download to promotion area when no t-shirt fundraiser.


# Meetup.com Integration Notes

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

Maybe pixelate the avatars?

  * http://close-pixelate.desandro.com
  * http://seuratjs.com
