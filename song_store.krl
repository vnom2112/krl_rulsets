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
    select when echo message msg_type re/^song$/ input "(.*)" setting(m)
    send_directive("sing") with
    song = m;
    always {
      raise explicit event 'sung'
      with song = m
    }
  }
  
  rule find_hymn is active {
    select when explicit sung re/god/i
    always {
      raise explicit event 'found_hymn'
      with song = event:attr('song')
    }
  }

  rule find_secular is active {
    select when explicit sung re/^(.(?!god))*$/i
    always {
      raise explicit event 'found_secular'
      with song = event:attr('song')
    }
  }
  
  rule foundHymn is active {
    select when explicit found_hymn
    send_directive("found")
    with song = "Found a Hymn!";
  }
  
  rule foundSecular is active {
    select when explicit found_secular
    send_directive("found")
    with song = "Found a Secular Song!";
  }
 
}
