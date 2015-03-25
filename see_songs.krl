ruleset see_song {
  meta {
    name "See Songs"
    description <<
Song ruleset
>>
    author "Brady Kelley"
    logging on
    sharing on
 
  }
  global {
 
  }
  
  rule songs is active {
    select when echo message input "(.*)" setting(m)
    send_directive("sing") with
    song = m;
    always {
      raise explicit event 'sung'
      with song = m
    }
  }
  
  rule find_hymn is active {
    select when explicit sung where song setting(song_title)
    always {
      raise explicit event 'found_hymn'
      if(song_title.match(re/god/i));
    }
  }
  
  rule found is active {
    select when explicit found_hymn
    send_directive("found")
    with song = "Found it!";
  }
 
}
