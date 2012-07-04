$ ->
   getRecentTracks displayRecentTracks

displayRecentTracks = (tracks) ->
  area    = $('#recent-music')
  artists = {}
  if tracks.track.length
    stepArtists 0, tracks, artists, ->
      for name, artist of artists
        area.find('h3').show()
        area.append "<a href='spotify:search:"+artist.name.replace(/\s/g, '+')+"'><img src='"+ artist.image[2]['#text']+"'/></a>"
## steps through each artist
stepArtists = (index, tracks, artists, cb) ->
  if index < tracks.track.length
    getArtist tracks.track[index].artist['#text'], (data) ->
      if artists[tracks.track[index].artist['#text']] == undefined
        artists[tracks.track[index].artist['#text']] = data
      stepArtists ++index, tracks, artists, cb
  else
    cb()

## Gets artist info from last.fm
getArtist = (id, cb) ->
  $.getJSON('http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist='+id+'&api_key=1a7c2b9bdb474400ca73abd6002471cf&format=json', (d) ->
    cb d.artist
  )

## Gets my recent tracks from last.fm
getRecentTracks = (cb) ->
  $.getJSON('http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=samccone&api_key=1a7c2b9bdb474400ca73abd6002471cf&limit=90&format=json', (d) ->
    cb d.recenttracks
  )